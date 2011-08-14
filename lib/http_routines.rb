# http://stackoverflow.com/questions/2263540/how-do-i-download-a-binary-file-over-http-using-ruby
module HttpRoutines
  def http_to_file(filename,url,opt={})
    opt = {
      :init_pause => 0.1,    #start by waiting this long each time
                             # it's deliberately long so we can see
                             # what a full buffer looks like
      :learn_period => 0.3,  #keep the initial pause for at least this many seconds
      :drop_factor => 1.5,          #fast reducing factor to find roughly optimized pause time
      :adjust => 1.05        #during the normal period, adjust up or down by this factor
    }.merge(opt)
    pause = opt[:init_pause]
    learn = 1 + (opt[:learn_period]/pause).to_i
    drop_period = true
    delta = 0
    max_delta = 0
    last_pos = 0
    File.open(filename, 'w'){ |f|
      uri = URI.parse(url)
      Net::HTTP.start(uri.host,uri.port){ |http|
        http.request_get(uri.path){ |res|
          res.read_body{ |seg|
            f << seg
            delta = f.pos - last_pos
            last_pos += delta
            if delta > max_delta then max_delta = delta end
            if learn <= 0 then
              learn -= 1
            elsif delta == max_delta then
              if drop_period then
                pause /= opt[:drop_factor]
              else
                pause /= opt[:adjust]
              end
            elsif delta < max_delta then
              drop_period = false
              pause *= opt[:adjust]
            end
            sleep(pause)
          }
        }
      }
    }
  end

  module_function :http_to_file
end