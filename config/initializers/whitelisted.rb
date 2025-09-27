# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.hosts << /.+\.puma-dev-dns\.(test|home)/
  config.hosts << /.*/

end

