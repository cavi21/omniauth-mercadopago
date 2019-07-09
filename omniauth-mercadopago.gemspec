# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-mercadopago/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-mercadopago"
  gem.version       = OmniAuth::Mercadopago::VERSION
  gem.authors       = ["Agustin Cavilliotti"]
  gem.email         = ["cavi21@gmail.com"]

  gem.description   = "A MercadoPago strategy for OmniAuth"
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/cavi21/omniauth-mercadopago"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").collect { |f| File.basename(f) }
  gem.require_paths = %w(lib)

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.4'

  gem.add_development_dependency "bundler", "~> 2.0"
  gem.add_development_dependency "rake", "~> 10.0"
end
