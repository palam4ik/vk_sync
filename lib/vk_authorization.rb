module VkAuthorization
  AUTHORIZATION_URL = "http://api.vkontakte.ru/oauth/authorize?client_id=2415282&scope=audio,offline&redirect_uri=http://api.vkontakte.ru/blank.html&display=page&response_type=token"

  def self.parse_authorization_response response
    option = {}
    response.split('&').each do |obj_str|
      key, value = obj_str.split '='
      option[key.to_sym] = value
    end
    option
  end

end
