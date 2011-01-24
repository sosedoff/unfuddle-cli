$:.unshift File.expand_path("../lib", __FILE__)
require "unfuddle/version"

Gem::Specification.new do |gem|
  gem.name    = "unfuddle-cli"
  gem.version = Unfuddle::VERSION

  gem.author      = "Dan Sosedoff"
  gem.email       = "dan.sosedoff@gmail.com"
  gem.homepage    = "http://github.com/sosedoff/unfuddle-cli"
  gem.summary     = "Console tool to manage Unfuddle repositories"
  gem.description = "Simple console tool that allows you to manage Unfuddle repositories and projects."
  gem.executables = "unfuddle"

  gem.add_dependency "rest-client", ">= 1.5.0"
  gem.add_dependency "activeresource", ">= 3.0.1"
end