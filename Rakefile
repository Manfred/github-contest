require 'rake/testtask'

task :default => :spec

Rake::TestTask.new('spec') do |t|
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

desc "Generate results.txt"
task :generate do
  sh File.expand_path('../bin/generate', __FILE__)
end