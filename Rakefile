task :default => [:test]

desc "Run all prawn's tests; test-spec and mocha required"
task :test do
  specs = Dir["vendor/prawn/spec/*_spec.rb"]
  specs.map! { |spec| "\"#{spec}\""}

  cmd = %Q{/usr/bin/ruby -I"vendor/prawn/lib" -I"vendor/prawn" -I"lib"
    -r 'rubygems' -r 'prawn/fast_png'
    "/usr/lib/ruby/gems/1.8/gems/rake-0.8.4/lib/rake/rake_test_loader.rb"
    #{specs.join(' ')}}
  cmd.gsub!("\n", '')

  system cmd
end
