class Observation
  def initialize
    @co_occurrence = Hash.new(false)
  end
  
  def assimilate(filename)
    File.open(filename) do |file|
      file.each_line do |line|
        user, project = line.split(':')
        @co_occurrence[[project.to_i, user.to_i]] = true
      end
    end
  end
  
  def length
    @co_occurrence.keys.length
  end
  
  def o(project, user)
    @co_occurrence[[project, user]]
  end
end