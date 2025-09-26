# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t vyzor .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name vyzor vyzor

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    usermod -aG 0 rails

RUN mkdir -p /bench/src /bench/bundle /bench/init && \
    chown -R 1000:1000 /bench && \
    chmod -R g=u /bench && \
    chmod g+s /bench
# Rails app lives here

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y git wget ncdu curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ARG RAILS_ENV=production
# Set production environment
ENV RAILS_ENV=$RAILS_ENV \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/bench/bundle" \
    BUNDLE_WITHOUT="development"

RUN gem update --system && \
    gem install bundle

RUN curl https://mise.run | MISE_INSTALL_PATH=/usr/local/bin/mise sh && \
    chmod +x /usr/local/bin/* && \
    su rails -c 'echo 'eval "$(/usr/local/bin/mise activate bash)"' >> /home/rails/.bashrc'

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config unzip && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

WORKDIR /bench/src

# Install application gems
COPY --chown=1000:1000 .ruby-version Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

RUN echo 'eval "$(/usr/local/bin/mise activate bash)"' >> /etc/bash.bashrc
#RUN su rails -c '/usr/local/bin/mise u -g npm yarn@1 node bun' && \
#    su rails -c '/usr/local/bin/mise trust --all'
RUN mise settings add idiomatic_version_file_enable_tools ruby
RUN mise i npm yarn@1 node && \
    mise trust --all

ENV BUN_INSTALL=/usr/local/bun
ENV PATH=/usr/local/bun/bin:$PATH
ARG BUN_VERSION=1.2.18
RUN curl -fsSL https://bun.sh/install | bash -s -- "bun-v${BUN_VERSION}"

# Copy application code
COPY --chown="1000:1000" . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/
# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 bin/rails assets:precompile


# Final stage for app image
FROM base

USER 1000

ENV GEM_HOME="/home/rails/.gems"
ENV PATH="/home/rails/.gems/bin:/home/rails/.local/share/gem/ruby/3.4.0/bin:${PATH}"
# Run and own only the runtime files as a non-root user for security

    # Copy built artifacts: gems, application
COPY --chown="1000:1000" --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --chown="1000:1000" --from=build /bench/src /bench/src

WORKDIR /bench/src

RUN mkdir -p db log storage tmp .git/safe && \
    chown -R rails:rails db log storage tmp && \
    chmod -R g=u /bench/src && \
    chmod g+s /bench/src && \
    chmod +x /bench/src/bin/* && \
    cp .buildops/gemrc /home/rails/.gemrc

# Entrypoint prepares the database.
ENTRYPOINT ["/bench/src/bin/docker-entrypoint"]

# Start server via Thruster by default, this can be overwritten at runtime
EXPOSE 80
CMD [ "./bin/thrust", "bin/puma","-C","config/puma.rb" ]
#CMD [ "bundle","exec","puma","-c","config/puma.rb" ]
#CMD ["./bin/thrust", "./bin/rails", "server"]
