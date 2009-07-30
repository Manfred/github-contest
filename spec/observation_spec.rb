require File.expand_path('../start', __FILE__)

describe "Observation" do
  it "should assimilate co-occurence data from a file" do
    observation = Observation.new
    observation.assimilate(fixture('data.txt'))
    
    observation.length.should == 5
    observation.o(17, 157).should  == true
    observation.o(155, 159).should == true
    observation.o(1, 1).should     == false
    observation.o(160, 156).should == false
  end
end