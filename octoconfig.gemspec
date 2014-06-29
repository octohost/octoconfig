# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','octoconfig','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'octoconfig'
  s.version = Octoconfig::VERSION
  s.author = 'Darron Froese'
  s.email = 'darron@froese.org'
  s.homepage = 'http://www.octohost.io'
  s.platform = Gem::Platform::RUBY
  s.licenses = ['Apache']
  s.summary = 'Setup octohost config files through Consul data.'
  s.description = "This is a gem used with the octohost project. It pulls data from Consul and outputs an nginx config file."
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','octoconfig.rdoc']
  s.rdoc_options << '--title' << 'octoconfig' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'octoconfig'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.11.0')
  s.add_runtime_dependency('json')
end
