# frozen_string_literal: true

source "https://rubygems.org"

gem "bootsnap", require: false
gem "jbuilder"
gem "jsbundling-rails"
gem "kamal", require: false
gem "pg", "~> 1.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rack-canonical-host"
gem "rails", "~> 8.0.3"
gem "solid_cable"
gem "solid_cache"
gem "solid_queue"
gem "stimulus-rails"
gem "thruster", require: false
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "dotenv", ">= 3.0"
  gem "factory_bot_rails"
  gem "launchy"
  gem "rspec-rails"
end

group :development do
  gem "annotaterb"
  gem "bundler-audit", require: false
  gem "erb_lint", require: false
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "web-console"
end

group :test do
  gem "capybara", require: false
  gem "capybara-lockstep", require: false
  gem "selenium-webdriver", require: false
  gem "vcr"
  gem "webmock"
end

gem "tailwindcss-ruby", "~> 4.1"
gem "tailwindcss-rails", "~> 4.3"
