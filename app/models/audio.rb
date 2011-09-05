class Audio
  include SanitizeFileName
  include DataMapper::Resource

  property :id,         Serial
  property :user_id,    Integer
  property :album_id,   Integer
  property :artist,     String
  property :title,      String
  property :duration,   Integer
  property :url,        String, length: 255, format: :url
  property :deleted,    Boolean, default: false, required: true
  property :downloaded, Boolean, default: false, required: true

  belongs_to :album
  belongs_to :user

  sanitize_writer :title, :artist

  def file_name
    ext = url.split('.').last
    if artist and title.nil?
      "#{artist}.#{ext}"
    elsif artist.nil? and title
      "#{title}.#{ext}"
    else
      "#{artist} — #{title}.#{ext}"
    end
  end

  def download_file
    return true if downloaded
    path = Settings.folders['audio']
    if album_id
      #TODO: add album_name to path
    end

    FileUtils.mkdir_p path unless Dir.exists? path

    file_path = path + "/#{file_name}"
    unless File.exists? file_path
      HttpRoutines.http_to_file file_path, url
      update :downloaded => true
    end
  end
end
