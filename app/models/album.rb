class Album
  include DataMapper::Resource

  property :id,       Serial
  property :album_id, Integer
  property :user_id,  Integer
  property :title,    String

  has n, :audios
  belongs_to :user
end
