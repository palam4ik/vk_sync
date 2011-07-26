require File.expand_path('../boot', __FILE__)

main_user = User.first(primary: true)
ACCESS_TOKEN = main_user.nil? ? nil : main_user.access_token
