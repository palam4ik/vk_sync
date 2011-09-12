require File.expand_path('spec/spec_helper')

describe Audio do
  describe "audio regexp" do
    it "should disable whitespaces in the end" do
      audio = Audio.new artist: " Artist", title: "Title ", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Artist — Title.mp3")
    end

    it "should replace spaces to one space in the middle" do
      audio = Audio.new artist: "Arist    artist  ", title: " Title ", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Arist artist — Title.mp3")
    end

    it "should replace symbols before the artist name" do
      audio = Audio.new artist: "★ The Beatles", title: "Title", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("The Beatles — Title.mp3")
    end


    it "should replace mnemonics to its symbol" do
      audio = Audio.new artist: "Bon Jovi", title: "It&#39;s My Life", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Bon Jovi — It's My Life.mp3")
    end

    it "should just create audio" do
      audio = Audio.new artist: "Artist", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Artist.mp3")
    end

    it "should replace spaces after artist name" do
      audio = Audio.new artist: "Ar1 , Ar2", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Ar1, Ar2.mp3")
    end

    it "should delete point at the end of the title" do
      audio = Audio.new artist: "Ar1.", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Ar1.mp3")
    end

    it "should remove bad symbols from the start" do
      audio = Audio.new title: "/ Some title", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Some title.mp3")
    end

    it "should use correct name" do
      audio = Audio.new title: "Some/title", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Some, title.mp3")
    end

    it "should put whitespace, if need one" do
      audio = Audio.new title: "Some(title)", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Some (title).mp3")
    end

    it "should replace / with comma" do
      audio = Audio.new title: "Ottorino Respighi - Pini di Roma / Пинии Рима (1924) - 3. I pini del Gianicolo / Пинии на Яникуле", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Ottorino Respighi - Pini di Roma, Пинии Рима (1924) - 3. I pini del Gianicolo, Пинии на Яникуле.mp3")
    end

    it "should replace too many commas only with three" do
      audio = Audio.new title: "Ты неси меня река.....", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Ты неси меня река....mp3")
    end

    it "should disable / in the beggining" do
      audio = Audio.new title: " / Some title", url: "http://vk.com/123.mp3"
      audio.file_name.should eql("Some title.mp3")
    end
  end
end
