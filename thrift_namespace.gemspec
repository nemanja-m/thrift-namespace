# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thrift_namespace/version'

Gem::Specification.new do |spec|
  spec.name          = "thrift_namespace"
  spec.version       = ThriftNamespace::VERSION
  spec.authors       = ["Rendered Text"]
  spec.email         = ["devops@renderedtext.com"]

  spec.summary       = %q{Inserts namespace int .thrift files.}
  spec.homepage      = "https://semaphoreci.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
