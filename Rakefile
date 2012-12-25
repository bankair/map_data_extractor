require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = Dir['test/*_test.rb']
end

desc "Run tests"
task default: [ :test ]
