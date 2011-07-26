require 'data_mapper'
require 'dm-yaml-adapter'

DataMapper.setup(:default, "yaml://#{APP_ROOT}/db")
