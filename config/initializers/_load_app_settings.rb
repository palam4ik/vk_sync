raw_settings = YAML::load(File.open APP_ROOT + "/config/app_settings.yml")
Settings = OpenStruct.new raw_settings[APP_ENV]
