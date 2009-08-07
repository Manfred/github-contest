require File.expand_path('../start', __FILE__)

describe "PLSA" do
  it "should approximate the observations more after more iterations" do
    observation = Observation.new
    observation.assimilate(fixture('data.txt'))
    plsa = PLSA.new(observation, :topics => 4, :max_iterations => 2)
    
    plsa.run
    likelihood1 = plsa.likelihood
    
    plsa.run
    likelihood2 = plsa.likelihood
    
    likelihood2.should > likelihood1
  end
  
end

describe "A PLSA" do
  before do
    @observation = Observation.new
    @observation.assimilate(fixture('data.txt'))
    @plsa = PLSA.new(@observation, :topics => 4, :max_iterations => 4)
    @plsa.run
  end
  
  before do
    Tempfiles.prepare!
  end
  
  after do
    Tempfiles.cleanup!
  end
  
  it "should dump its probabilistic network to disk" do
    file = tempfile('dump.bin')
    @plsa.dump(file)
    
    File.should.exists(file)
    File.size(file).should > 0
    File.read(file, 2).should == "\004\b"
  end
  
  it "should read a probabilistic network from disk" do
    file = tempfile('dump.bin')
    @plsa.dump(file)
    
    plsa = PLSA.new(@observation, :topics => 25_000, :max_iterations => 4)
    plsa.load(file)
    
    plsa.all_z.should == (0..4)
    [:all_z, :p_z_pu, :p_p_z, :p_u_z, :p_z, :last_likelihood].each do |internal|
      plsa.send(internal).should == @plsa.send(internal)
    end
  end
end