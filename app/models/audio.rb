class Audio
  include DataMapper::Resource

  property :id,       Serial
  property :user_id,  Integer
  property :album_id, Integer
  property :artist,   String
  property :title,    String
  property :duration, Integer
  property :url,      String, length: 255, format: :url
  property :deleted,  Boolean, default: false, required: true

  belongs_to :album
  belongs_to :user

  def file_name
    "#{artist} — #{title}.#{url.split('.').last}".gsub('&quot;', '"').gsub('/', '')
  end

  def download_file
    path = Settings.folders['audio']
    if album_id
      #TODO: add album_name to path
    end

    FileUtils.mkdir_p path unless Dir.exists? path

    file_path = path + "/#{file_name}"
    unless File.exists? file_path
      HttpRoutines.http_to_file file_path, url
    end
  end
end