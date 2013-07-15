# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sassy/version'

Gem::Specification.new do |spec|
  spec.name          = "sassy"
  spec.version       = Sassy::VERSION
  spec.authors       = ["Tim Jegels"]
  spec.email         = ["tjegels@gmail.com"]
  spec.description   = "Exports data to SSS standard"
  spec.summary       = "Exports data to SSS standard"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "builder", "~> 3.0.4"
  spec.add_development_dependency "rspec", "~> 2.12"
  spec.add_development_dependency "guard", "~> 1.8.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "nokogiri"
end
