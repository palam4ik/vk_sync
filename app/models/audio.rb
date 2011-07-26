class Audio
  include DataMapper::Resource

  property :id, Integer
  property :user_id, Integer
  property :album_id, Integer
  property :artist, String
  property :title, String
  property :duration, Integer
  property :url, String

  belongs_to :album
  belongs_to :user

end
