# frozen_string_literal: true

require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.hosts << /.+\.(ams-ix|grid-os|engineering)\.(test|net)/
  config.hosts << /.+\.apigator.*\.(test|net)/
  config.hosts << /.+\.vacuum\.rocks/
  config.hosts << /.+\.ixapi-stack\.test/
  config.hosts << /.*/

end

