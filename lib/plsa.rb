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
    all_z.each do |z|
      observation.projects.each do |project|
        observation.users.each do |user|
          p_z_pu[[z, project, user]] =
            (p_z[z] * p_p_z[[project, z]] * p_u_z[[user, z]]) /
            all_z.inject(0.0) { |t, _z| t + p_z[_z] * p_p_z[[project, _z]] * p_u_z[[user, _z]] }
        end
      end
    end
  end
  
  def m_step
    all_z.each do |z|
      observation.projects.each do |project|
        p_p_z[[project, z]] = observation.users.inject(0.0) { |t, _user| t + observation.o(project, _user) * p_z_pu[[z, project, _user]] }
      end
      observation.users.each do |user|
        p_u_z[[user, z]] = observation.projects.inject(0.0) { |t, _project| t + observation.o(_project, user) * p_z_pu[[z, _project, user]] }
      end
      p_z[z] = observation.projects.inject(0.0) do |p_total, project|
        p_total + observation.users.inject(0.0) do |u_total, user|
          u_total + observation.o(project, user) * p_z_pu[[z, project, user]]
        end
      end
    end
  end
end