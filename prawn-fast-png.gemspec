Gem::Specification.new do |s|
  s.name = "prawn-fast-png"
  s.rubyforge_project = "prawn-fast-png"
  s.homepage = "http://github.com/amberbit/prawn-fast-png"
  s.version = "0.2.3"
  s.authors = ["Wojciech Piekutowski"]
  s.email = "wojciech@piekutowski.net"
  s.files = ['lib/prawn/fast_png.rb', 'lib/prawn/images/png_patch.rb']
  s.description = s.summary = <<-END
    An extension of Prawn that improves the performance when embedding PNG
    images containing an alpha channel
  END
  s.add_dependency("prawn")
  s.add_dependency("rmagick")
  s.extra_rdoc_files = %w{README.rdoc LICENSE COPYING}
  s.rdoc_options << "--title" << "prawn-fast-png documentation" <<
                    "--main"  << "README.rdoc" << "-q"
end

