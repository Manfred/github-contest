require File.expand_path('../start', __FILE__)

class Regression < Test::Unit::TestCase
  def test_examples_return_expected_results
    Dir.glob(File.expand_path('../examples/*', __FILE__)).each do |dir|
      recommender = Recommender.run(
        :data_file => File.join(dir, 'data.txt'),
        :results_file => File.join(dir, 'results.txt'),
        :users_file => File.join(dir, 'test.txt')
      )
      assert_equal 5, recommender.recommendations.length
    end
  end
end
