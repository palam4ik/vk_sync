APP_ENV = 'test'

require File.expand_path('../../config/application', __FILE__)
require 'rspec'
require 'webmock/rspec'

Dir[APP_ROOT + "/spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :each do
    User.repository.adapter.execute "DELETE FROM users CASCADE"
    Audio.repository.adapter.execute "DELETE FROM audios CASCADE"
    Album.repository.adapter.execute "DELETE FROM albums CASCADE"
  end
end
