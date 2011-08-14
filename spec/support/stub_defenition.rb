def stub_audio_get options = {}
  unless options[:access_token]
    options[:access_token] = User.first.access_token
  end

  stub_request(:get, "https://api.vkontakte.ru/method/audio.get?access_token=929")
end
