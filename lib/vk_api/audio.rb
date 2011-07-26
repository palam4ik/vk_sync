module VkApi
  class Audio < Base
    %w(get get_by_id get_lyrics get_upload_server).each do |method|
      define_method method do |opts|
        body = do_request "audio.#{method}", :get
      end
    end

    def save
    end

    def search
    end

    def add
    end

    def delete
    end

    def edit
    end

    def restore
    end

    def reorder
    end
  end
end
