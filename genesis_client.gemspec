# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'genesis_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'genesis_client'
  spec.version       = GenesisClient::VERSION
  spec.authors       = ['David Radcliffe']
  spec.email         = ['david.radcliffe@shopify.com']

  spec.summary       = 'Ruby client library for the Genesis API'
  spec.homepage      = 'https://github.com/Shopify/genesis_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
end
