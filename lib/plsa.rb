class PLSA
  attr_accessor :observation
  attr_accessor :p_z_pu, :p_p_z, :p_u_z, :p_z
  attr_accessor :iterations, :all_z
  
  def initialize(observation, options={})
    @observation = observation
    
    @iterations = options[:iterations]||100
    @all_z      = (0..options[:topics]||101)
    
    srand
    r = Proc.new { |hash, key| hash[key] = rand }
    
    @p_z_pu = Hash.new(&r)
    @p_p_z  = Hash.new(&r)
    @p_u_z  = Hash.new(&r)
    @p_z    = Hash.new(&r)
  end
  
  def run
    iterations.times do
      e_step
      m_step
    end
  end
  
  private
  
  def e_step
    for z in all_z
      for project in observation.projects
        for user in observation.users
          t = 0.0
          for _z in all_z
            t += p_z[_z] * p_p_z[[project, _z]] * p_u_z[[user, _z]]
          end
          p_z_pu[[z, project, user]] = (p_z[z] * p_p_z[[project, z]] * p_u_z[[user, z]]) / t
        end
      end
    end
  end
  
  def m_step
    for z in all_z
      for project in observation.projects
        t = 0.0
        for user in observation.users
          t += observation.o(project, user) * p_z_pu[[z, project, user]]
        end
        p_p_z[[project, z]] = t
      end
      
      for user in observation.users
        t = 0.0
        for project in observation.projects
          t += observation.o(project, user) * p_z_pu[[z, project, user]]
        end
        p_u_z[[user, z]] = t
      end
      
      t = 0.0
      for project in observation.projects
        for user in observation.users
          t += observation.o(project, user) * p_z_pu[[z, project, user]]
        end
      end
      p_z[z] = t
    end
  end
end