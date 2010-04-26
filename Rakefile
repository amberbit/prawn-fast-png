require 'rubygems'
require 'rake'
require 'rake/testtask'

prawn_fast_png_lib = File.join(File.dirname(__FILE__), 'lib')
prawn_dir = ENV['PRAWN_DIR'] || '../../prawn/src'
prawn_require = ENV['PRAWN_REQUIRE'] || 'prawn' # use prawn/core for 0.8, 0.7, 0.6, 0.5
prawn_dir = File.expand_path(prawn_dir)
puts "(in #{prawn_dir})"
Dir.chdir prawn_dir

task :default => [:test]

desc "Run all tests, test-spec, mocha, and pdf-reader required"
Rake::TestTask.new do |test|
  test.ruby_opts  << "-r'#{prawn_require}' -r'prawn/fast_png'"
  test.libs       << prawn_fast_png_lib
  test.libs       << "spec"
  test.test_files =  Dir["spec/*_spec.rb"]
  test.verbose    =  true
end

