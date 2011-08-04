class User
  include DataMapper::Resource
  property :id,           Serial
  property :user_id,      Integer, :required => true
  property :access_token, Text
  property :expires_in,   Integer
  property :primary,      Boolean, :default => false

  has n, :albums
  has n, :audios

  class << self
    def create_from_auth_hash hash
      user_hash = hash.merge! primary: true
      User.create user_hash
    end
  end
end
