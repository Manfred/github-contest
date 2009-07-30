module Fixtures
  def fixture(path)
    File.join(File.expand_path('../../fixtures', __FILE__), path)
  end
end

class Test::Unit::TestCase
  include Fixtures
end