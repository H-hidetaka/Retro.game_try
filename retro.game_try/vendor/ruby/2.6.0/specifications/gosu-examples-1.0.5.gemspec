# -*- encoding: utf-8 -*-
# stub: gosu-examples 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "gosu-examples".freeze
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Julian Raschke".freeze]
  s.date = "2018-09-04"
  s.description = "The `gosu-examples` tool provides an easy way to run and inspect example games written for the Gosu game development library.".freeze
  s.email = "julian@raschke.de".freeze
  s.executables = ["gosu-examples".freeze]
  s.files = ["bin/gosu-examples".freeze]
  s.homepage = "http://www.libgosu.org/".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2".freeze)
  s.rubygems_version = "3.2.3".freeze
  s.summary = "Ruby examples for the Gosu library".freeze

  s.installed_by_version = "3.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<gosu>.freeze, [">= 0.11.0"])
  else
    s.add_dependency(%q<gosu>.freeze, [">= 0.11.0"])
  end
end
