APP_ENV = 'test'

require File.expand_path('../../config/application', __FILE__)
require 'rspec'
require 'webmock/rspec'

Dir[APP_ROOT + "/spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :each do
    DataMapper.auto_migrate!
  end
end
