ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../app/fractal_now'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
