require File.expand_path('../start', __FILE__)

describe "A newly created observation" do
  it "should have zero length" do
    Observation.new.length.should.be.zero
  end
  
  it "should not break when querying for occurences" do
    lambda {
      Observation.new.o(1, 2)
    }.should.not.raise
  end
end

describe "An observation" do
  it "should assimilate co-occurence data from a file" do
    observation = Observation.new
    observation.assimilate(fixture('data.txt'))
    
    observation.length.should == 5
    observation.projects.should == Set.new([17, 153, 154, 155, 156])
    observation.users.should == Set.new([89, 157, 158, 159, 160])
    
    observation.o(17, 157).should  == 1
    observation.o(155, 159).should == 1
    observation.o(1, 1).should     == 0
    observation.o(160, 156).should == 0
  end
end