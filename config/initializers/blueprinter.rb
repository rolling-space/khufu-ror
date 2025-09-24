
Blueprinter.configure do |config|
  config.generator = Yajl::Encoder # default is JSON
  config.method = :encode # default is generate
end
