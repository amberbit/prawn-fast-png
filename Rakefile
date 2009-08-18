task :default => [:test]

desc "Run all prawn's tests; test-spec and mocha required"
task :test do
  require 'prawn'
  prawn_core_spec = Gem.loaded_specs['prawn-core']
  prawn_core_path = prawn_core_spec.full_gem_path
  prawn_fast_png = File.join(File.dirname(__FILE__), 'lib', 'prawn', 'fast_png.rb')
  cmd = "cd #{prawn_core_path}; rake test TESTOPTS='-I #{prawn_fast_png}'"
  system cmd
end

