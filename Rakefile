task :default => [:test]

desc "Run all prawn's tests; test-spec and mocha required"
task :test do
  gem 'prawn', ENV['PRAWN_VERSION'] if ENV['PRAWN_VERSION']
  require 'prawn'

  prawn_core_spec = Gem.loaded_specs['prawn-core']
  # prawn 0.4.0 doesn't provide prawn-core gem
  prawn_core_spec = Gem.loaded_specs['prawn'] unless prawn_core_spec
  prawn_core_path = prawn_core_spec.full_gem_path
  prawn_fast_png = File.join(File.dirname(__FILE__), 'lib', 'prawn', 'fast_png.rb')
  cmd = "cd #{prawn_core_path}; rake test TESTOPTS='-I #{prawn_fast_png}'"
  system cmd
end

