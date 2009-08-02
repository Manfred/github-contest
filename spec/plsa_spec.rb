require File.expand_path('../start', __FILE__)

describe "PLSA" do
  it "should run an E step for a simple set of observations" do
    observation = Observation.new
    observation.assimilate(fixture('data.txt'))
    
    plsa = PLSA.new(observation, :topics => 4, :max_iterations => 20)
    plsa.run
  end
end