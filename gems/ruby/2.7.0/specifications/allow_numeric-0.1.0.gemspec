# -*- encoding: utf-8 -*-
# stub: allow_numeric 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "allow_numeric".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Abhishek Kanojia".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-03-29"
  s.description = " This gem provides easy way to restrict numeric input to input fields using jquery and integrates with Rails asset pipeline for easy of use. ".freeze
  s.email = ["abhishek.kanojia3193@gmail.com".freeze]
  s.homepage = "https://github.com/abhikanojia/allow_numeric".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "This gem provides easy way to restrict numeric input to input fields using jquery.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<jquery-rails>.freeze, ["~> 4.3"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.3"])
  end
end
