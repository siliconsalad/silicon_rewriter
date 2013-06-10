# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'silicon_rewriter/version'

Gem::Specification.new do |spec|
  spec.name          = 'silicon_rewriter'
  spec.version       = SiliconRewriter::VERSION
  spec.authors       = ['Baptiste Lecocq']
  spec.email         = ['baptiste.lecocq@gmail.com']
  spec.description   = 'An URL rewriter based on a simple hash'
  spec.summary       = 'An URL rewriter based on a simple hash'
  spec.homepage      = 'https://github.com/siliconsalad/silicon_rewriter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rspec-rails'
end
