gemfile = File.expand_path('../../Gemfile', __FILE__)

APP_ROOT = "#{File.dirname(__FILE__)}/.."
require APP_ROOT + "/lib/initializer"

APP_ENV ||= 'development'

begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  require 'bundler/setup'
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

Initializer.load do
  gems
  lib_classes
  config_initializers
  application_classes
  finalizing_models
end
