irb = RUBY_PLATFORM =~ /(:?mswin|mingw)/ ? 'irb.bat' : 'irb'

require 'optparse'
options = {sandbox: false, irb: irb}
OptionParser.new do |opt|
  opt.on("--debugger", "Enable ruby-debugging for the consonle") {|v| v options[:debugger] = v}
end

libs = " -r irb/completion"
libs << " -r #{File.expand_path(File.dirname(__FILE__))}/../../config/application"

if options[:debugger]
  begin
    require 'ruby-debug'
    libs << " -r ruby-debug"
    p "=> Debugger enabled"
  rescue
    p "You need to install ruby-debug to run the console in debugging mode"
    exit
  end
end

exec "#{options[:irb]} #{libs}"
