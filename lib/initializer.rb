module Initializer
  class << self
    def application_classes
      Dir.glob("#{APP_ROOT}/app/**/*.rb").sort.each do |file|
        require file
      end
    end

    def finalizing_models
      DataMapper.finalize
      DataMapper.auto_migrate!
      DataMapper.auto_upgrade!
    end

    def lib_classes
      Dir.glob("#{APP_ROOT}/lib/*.rb").sort.each do |file|
        require file
      end
    end

    def config_initializers
      Dir.glob("#{APP_ROOT}/config/initializers/*.rb").sort.each do |file|
        require file
      end
    end

    def gems
      require 'data_mapper'
      require 'dm-migrations'
      require 'json'
      require 'yaml'
      require 'ostruct'
    end

    def logger
    end

    def load &block
      instance_eval &block
    end
  end
end
