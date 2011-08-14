DataMapper.setup(:default, "#{Settings.adapter}://#{Settings.host}/#{Settings.database}")

# Setting default options
DataMapper::Property::String.length(255)