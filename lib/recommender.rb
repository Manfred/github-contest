class Recommender
  attr_accessor :options, :observation, :plsa, :users, :recommendations
  
  def initialize(options)
    @options = options
    
    @observation = Observation.read(options[:data_file])
    @plsa = PLSA.new(@observation, :topics => 3, :max_iterations => 20)
    @users = Users.read(options[:users_file])
  end
  
  def write_to_file
    File.open(options[:results_file], 'w') do |file|
      recommendations.each do |user, recommendation|
        file.write("#{user}:#{recommendation.join(',')}\n")
      end
    end
  end
  
  def weight(user, project)
    w = 0.0; for z in plsa.all_z
      w += (plsa.p_u_z[[user, z]] * plsa.p_p_z[[project, z]] * (plsa.p_z[z]**2)) /
        (plsa.p_u(user) * plsa.p_p(project))
    end; w
  end
  
  def calculate_recommendations
    @recommendations = {}
    @users.each do |user|
      project_weights = []
      observation.projects.each do |project|
        project_weights << [weight(user, project), project]
      end
      project_weights.sort!
      @recommendations[user] = project_weights[0..9].map { |_, project| project }
    end
  end
  
  def run
    plsa.run
    calculate_recommendations
  end
  
  def self.run(options)
    recommender = new(options)
    recommender.run
    recommender
  end
end