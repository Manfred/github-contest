require 'fileutils'

module Tempfiles
  def self.tempdir
    File.expand_path('../../tmp', __FILE__)
  end
  
  def self.prepare!
    cleanup!
    FileUtils.mkdir_p(tempdir)
  end
  
  def self.cleanup!
    FileUtils.rm_rf(tempdir)
  end
  
  def tempfile(path)
    File.join(Tempfiles.tempdir, path)
  end
end

class Test::Unit::TestCase
  include Tempfiles
end