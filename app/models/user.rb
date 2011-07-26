class User
  include DataMapper::Resource

  property :user_id,      Integer
  property :access_token, Text
  property :expires_in,   Integer
  property :primary,      Boolean, :default => false

  class << self
    def count
      User.all.size
    end
  end

  has n, :albums
  has n, :audios
end
