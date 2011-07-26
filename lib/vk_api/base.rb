module VkApi
  class Base
    RESPONSE_CODES = {
      200 => :success
    }

    base_url = "http://api.vkontakte.ru"

    def do_request method, options, http_request_type = :get
      Timeout.timeout(15) do
        if http_request_type == :get
          open(constuct_url(method, options)).read
        else
          raise "TODO"
        end
      end
    rescue Timeout::Error
      nil
    end

    def constuct_url method, options
      options[:access_token] = ACCESS_TOKEN
      "#{base_url}/#{method}?#{hash_to_params options}"
    end

    def hash_to_params options
      options.keys.map{|key| "#{key.to_s}=#{options[key].to_s}"}.join '&'
    end
  end
end
