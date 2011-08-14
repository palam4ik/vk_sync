require File.expand_path('spec/spec_helper')

describe Audio do
  it "should use correct name" do
    a1 = Audio.new artist: " Artist", title: "Title "
    a1.file_name.should eql("Artist — Title")
  end
end