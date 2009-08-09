require File.expand_path('../start', __FILE__)

describe "Users" do
  it "should read a file with users" do
    users = Users.read(fixture('test.txt'))
    users.length.should == 5
    expected = [157, 158, 89, 159, 160]
    (users - expected).should.be.empty?
    (expected - users).should.be.empty? 
  end
end