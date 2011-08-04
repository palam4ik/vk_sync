require File.expand_path('spec/spec_helper')

describe VkApi do

  before do
    @user = User.create primary: true, user_id: 123, access_token: 'access_token'
  end

  it "should send request and parse response" do
    audio = Audio.new
    audio.get
  end
end
