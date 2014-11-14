# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/client_spec/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-client_spec"
  spec.version       = Rack::ClientSpec::VERSION
  spec.authors       = ["harukasan"]
  spec.email         = ["harukasan@me.com"]
  spec.summary       = %q{Rack middleware for test client behavior}
  spec.description   = %q{Rack middleware for test client behavior. It can test client request to your rack applications. }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "rack", "~> 1.5"
  spec.add_dependency "power_assert", "~> 0.2"
  spec.add_dependency "ansi", "~> 1.4.3"
end
