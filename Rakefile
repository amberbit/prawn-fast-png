require 'rubygems'
require 'rake'
require 'rake/testtask'

prawn_fast_png_lib = File.join(File.dirname(__FILE__), 'lib')

# find out where prawn source code exists
gem 'prawn', ENV['PRAWN_VERSION'] if ENV['PRAWN_VERSION']
require 'prawn'
prawn_core_spec = Gem.loaded_specs['prawn-core']
prawn_core_spec = Gem.loaded_specs['prawn'] unless prawn_core_spec
Dir.chdir prawn_core_spec.full_gem_path

task :default => [:test]

desc "Run all tests, test-spec, mocha, and pdf-reader required"
Rake::TestTask.new do |test|
  test.ruby_opts  << "-r\"rubygems\" -I\"#{prawn_fast_png_lib}\" -r\"prawn/fast_png\""
  test.libs       << "spec"
  test.test_files =  Dir["spec/*_spec.rb"]
  test.verbose    =  true
end

