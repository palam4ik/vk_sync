require File.expand_path('spec/spec_helper')

describe 'VkAuthorization' do
  before :all do
    @klass = Class.new
    @klass.send :include, VkAuthorization
  end

  it "parse_authorization_response should parse direct strig" do
    result = @klass.parse_authorization_response "access_token=929&expires_in=0&user_id=3660651"
    result.should eql({:access_token => '929', :expires_in => '0', :user_id => '3660651'})
  end

  it "parse_authorization_response should parse url" do
    result = @klass.parse_authorization_response "http://api.vkontakte.ru/blank.html#access_token=929&expires_in=0&user_id=3660651"
    result.should eql({:access_token => '929', :expires_in => '0', :user_id => '3660651'})
  end
end
