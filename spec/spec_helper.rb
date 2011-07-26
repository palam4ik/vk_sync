APP_ENV = 'test'

require 'rspec'
require 'webmock/rspec'

Dir[APP_ROOT + "/spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
