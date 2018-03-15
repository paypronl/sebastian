lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sebastian/version'

Gem::Specification.new do |gem|
  gem.name     = 'sebastian'
  gem.version  = Sebastian::VERSION
  gem.authors  = ['Sander Tuin']
  gem.email    = ['sander@paypro.nl']

  gem.summary  = 'Your personal demon butler at your services.'
  gem.homepage = 'https://github.com/paypronl/sebastian'
  gem.license  = 'MIT'

  gem.require_paths = ['lib']
  gem.required_ruby_version = '>= 2.2.2'

  gem.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  gem.add_dependency 'activemodel', '>= 4', '< 6'

  gem.add_development_dependency 'bundler', '~> 1.16'
  gem.add_development_dependency 'pry', '~> 0.11'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.0'

  gem.add_development_dependency 'rspec_junit_formatter', '~> 0.3'
  gem.add_development_dependency 'rubocop', '~> 0.52.0'
end
