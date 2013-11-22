# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'un_locode/version'

Gem::Specification.new do |spec|
  spec.name          = 'un_locode'
  spec.version       = UnLocode::VERSION
  spec.authors       = ['Michel de Graaf']
  spec.email         = ['michel@re-invention.nl']
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3.5'
  spec.add_development_dependency 'rake', '~> 10.1.0'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'pry', '~> 0.9.12.3'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_dependency 'activerecord', '~> 4.0.0'
  spec.add_dependency 'sqlite3', '~> 1.3.8'
end
