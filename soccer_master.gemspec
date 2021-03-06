# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soccer_master/version'

Gem::Specification.new do |spec|
  spec.name          = "soccer_master"
  spec.version       = SoccerMaster::VERSION
  spec.authors       = ["Lucas Aragno"]
  spec.email         = ["lucas.aragno157@gmail.com"]

  spec.summary       = %q{this is a command line tool to calculate soccer league results based on files}
  spec.description   = %q{this is a command line tool to calculate soccer league results based on files}
  spec.homepage      = ""

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = ["lib"]
  spec.executables = ["soccer_master"]
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.15"
end
