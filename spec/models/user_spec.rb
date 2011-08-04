require File.expand_path('spec/spec_helper')

describe 'User' do
  it "create user" do
    auth_result = {:access_token => '929', :expires_in => '0', :user_id => '3660651'}
    User.create_from_auth_hash auth_result
    User.count.should eql(1)
    User.first.user_id.should eql(auth_result[:user_id].to_i)
    User.first.access_token.should eql(auth_result[:access_token])
  end
end
