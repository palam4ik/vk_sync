class User
  include VkAuthorization

  include DataMapper::Resource
  property :id,           Serial
  property :access_token, Text
  property :expires_in,   Integer
  property :primary,      Boolean, default: false

  has n, :albums
  has n, :audios

  class << self
    def create_from_auth_hash hash
      hash['id'] = hash.delete('user_id')
      User.create hash.merge(primary: true)
    end
  end

  def client
    def client; @@client end

    @@client ||= Vk.new access_token
  end

  def download_audio
    audios = client.audio_get
    if audios.ok?
      for audio in audios.body.response
        unless Audio.get(audio.aid)
          Audio.create id: audio.aid,
                       user_id: audio.owner_id,
                       artist: audio.artist,
                       title: audio.title,
                       duration: audio.duration,
                       url: audio.url
        end
      end
    end
    audios
  end

  def download_albums_name

  end
end
