module VkAuthorization
  extend ActiveSupport::Concern

  AUTHORIZATION_URL = "http://api.vkontakte.ru/oauth/authorize?client_id=2415282&scope=audio,offline&redirect_uri=http://api.vkontakte.ru/blank.html&display=page&response_type=token"
  included do
    API_VK_URL = AUTHORIZATION_URL[0..23]
  end

  module ClassMethods
    def parse_authorization_response response
      if response.start_with? API_VK_URL
        _get_token_from_url response
      else
        _parse_string response
      end
    end

    def _parse_string string
      option = {}
      string.split('&').each do |obj_str|
        key, value = obj_str.split '='
        option[key.to_sym] = value
      end
      option
    end

    def _get_token_from_url url
      _parse_string url.split('#')[-1]
    end
  end

end
