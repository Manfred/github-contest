require 'rake/testtask'

task :default => :verify

Rake::TestTask.new('spec') do |t|
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

Rake::TestTask.new('test') do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

desc "Run all specs and tests"
task :verify => [:spec, :test]

desc "Generate results.txt"
task :generate do
  sh File.expand_path('../bin/generate', __FILE__)
end