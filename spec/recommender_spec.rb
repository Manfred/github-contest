require File.expand_path('../start', __FILE__)

describe "Recommender given the command to run" do
  before { Tempfiles.prepare! }
  after  { Tempfiles.cleanup! }
  
  before do
    @results_file = tempfile('results.txt')
    @recommender = Recommender.run(
      :data_file    => fixture('data.txt'),
      :users_file    => fixture('test.txt'),
      :results_file => @results_file
    )
  end
  
  it "should write a recommendation" do
    @recommender.write_to_file
    File.should.exist(@results_file)
    File.size(@results_file).should > 0
  end
  
  it "should have trained" do
    @recommender.plsa.likelihood.should > 0
  end
end

describe "A recommender" do
  before do
    @recommender = Recommender.new(
      :data_file    => fixture('data.txt'),
      :users_file    => fixture('test.txt'),
      :results_file => @results_file
    )
  end
  
  it "should read observation data" do
    @recommender.observation.length.should == 5
  end
  
  it "should read the users to recommend for" do
    @recommender.users.length.should == 5
  end
  
  it "should intialize the PLSA trainer" do
    @recommender.plsa.observation.should == @recommender.observation
  end
end