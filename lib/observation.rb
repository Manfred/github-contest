require 'set'

class Observation
  attr_reader :users, :projects
  
  def initialize
    @co_occurrence = Hash.new(0)
    
    @users    = Set.new
    @projects = Set.new
  end
  
  def assimilate(filename)
    File.open(filename) do |file|
      file.each_line do |line|
        user, project = line.split(':')
        
        @users << user.to_i
        @projects << project.to_i
        
        @co_occurrence[[project.to_i, user.to_i]] = 1
      end
    end
  end
  
  def length
    @co_occurrence.keys.length
  end
  
  def o(project, user)
    @co_occurrence[[project, user]]
  end
  
  def self.read(filename)
    observation = new
    observation.assimilate(filename)
    observation
  end
end