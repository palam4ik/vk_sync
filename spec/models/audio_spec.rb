require File.expand_path('spec/spec_helper')

describe Audio do
  describe "audio regexp" do
    it "should disable whitespaces in the end" do
      a1 = Audio.new artist: " Artist", title: "Title ", url: "http://vk.com/123.mp3"
      a1.file_name.should eql("Artist — Title.mp3")
    end

    it "all tests" do
      a2 = Audio.new artist: "Arist    artist  ", title: " Title ", url: "http://vk.com/123.mp3"
      a2.file_name.should eql("Arist artist — Title.mp3")

      a3 = Audio.new artist: "★ The Beatles", title: "Title", url: "http://vk.com/123.mp3"
      a3.file_name.should eql("The Beatles — Title.mp3")

      a4 = Audio.new artist: "Bon Jovi", title: "It&#39;s My Life", url: "http://vk.com/123.mp3"
      a4.file_name.should eql("Bon Jovi — It's My Life.mp3")

      a5 = Audio.new artist: "Artist", url: "http://vk.com/123.mp3"
      a5.file_name.should eql("Artist.mp3")

      a6 = Audio.new artist: "Ar1 , Ar2", url: "http://vk.com/123.mp3"
      a6.file_name.should eql("Ar1, Ar2.mp3")

      a7 = Audio.new artist: "Ar1.", url: "http://vk.com/123.mp3"
      a7.file_name.should eql("Ar1.mp3")
    end

    it "should remove bad symbols from the start" do
      a9 = Audio.new title: "/ Some title", url: "http://vk.com/123.mp3"
      a9.file_name.should eql("Some title.mp3")
    end

    it "should use correct name" do
      a10 = Audio.new title: "Some/title", url: "http://vk.com/123.mp3"
      a10.file_name.should eql("Some, title.mp3")
    end

    it "should put whitespace, if need one" do
      a10 = Audio.new title: "Some(title)", url: "http://vk.com/123.mp3"
      a10.file_name.should eql("Some (title).mp3")
    end

    it "should replace / with comma" do
      a10 = Audio.new title: "Ottorino Respighi - Pini di Roma / Пинии Рима (1924) - 3. I pini del Gianicolo / Пинии на Яникуле", url: "http://vk.com/123.mp3"
      a10.file_name.should eql("Ottorino Respighi - Pini di Roma, Пинии Рима (1924) - 3. I pini del Gianicolo, Пинии на Яникуле.mp3")
    end

    it "should replace too many commas only with three" do
      a10 = Audio.new title: "Ты неси меня река.....", url: "http://vk.com/123.mp3"
      a10.file_name.should eql("Ты неси меня река....mp3")
    end

    it "should disable / from start" do
      a10 = Audio.new title: " / Some title", url: "http://vk.com/123.mp3"
      a10.file_name.should eql("Some title.mp3")
    end
  end
end
