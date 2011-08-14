require File.expand_path('spec/spec_helper')

describe 'User' do
  it "create user" do
    auth_result = {:access_token => '929', :expires_in => '0', 'id' => '3660651'}
    User.create_from_auth_hash auth_result
    User.count.should eql(1)
    p User.first
    User.first.id.should eql(auth_result['id'].to_i)
    User.first.access_token.should eql(auth_result[:access_token])
  end

  it "client method" do
    auth_result = {:access_token => '929', :expires_in => '0', :id => '3660651'}
    user = User.create_from_auth_hash auth_result
    user.client.class.should eql(Vk::Client)
  end

  describe ".audio" do
    before do
      auth_result = {:access_token => '929', :expires_in => '0', :id => '3660651'}
      @user = User.create_from_auth_hash auth_result
    end

    it "user should download audio" do
      stub_audio_get.to_return(:body => %{{"response":[{"aid":"60830458","owner_id":"#{@user.id}","artist":"Noname","title":"Bosco", "duration":"195","url":"http://cs40.vkontakte.ru/u06492/audio/2ce49d2b88.mp3"}, {"aid":"59317035","owner_id":"#{@user.id}","artist":"Mestre Barrao","title":"Sinhazinha", "duration":"234","url":"http://cs510.vkontakte.ru/u2082836/audio/d100f76cb84e.mp3"}]}})
      @user.download_audio
      Audio.count.should eql(2)
    end
  end
end
