class Users
  def self.read(filename)
    users = []
    File.open(filename) do |file|
      file.each_line do |line|
        users << line.to_i
      end
    end
    users
  end
end