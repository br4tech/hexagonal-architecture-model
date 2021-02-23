# -*- encoding: utf-8 -*-
# stub: correios-cep 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "correios-cep".freeze
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fernando Hamasaki de Amorim".freeze]
  s.date = "2020-02-17"
  s.description = "Correios CEP gem finds updated Brazilian addresses by zipcode, directly from Correios database. No HTML parsers.".freeze
  s.email = "prodis@gmail.com".freeze
  s.homepage = "https://github.com/prodis/correios-cep".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Correios CEP gem finds updated Brazilian addresses by zipcode, directly from Correios database. No HTML parsers.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<ox>.freeze, ["~> 2.13"])
    s.add_runtime_dependency(%q<http>.freeze, ["~> 4.3"])
    s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8.23"])
    s.add_development_dependency(%q<pry>.freeze, ["~> 0.12.2"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_development_dependency(%q<vcr>.freeze, ["~> 5.1"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 3.8"])
  else
    s.add_dependency(%q<ox>.freeze, ["~> 2.13"])
    s.add_dependency(%q<http>.freeze, ["~> 4.3"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.23"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.12.2"])
    s.add_dependency(%q<rake>.freeze, ["~> 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9"])
    s.add_dependency(%q<vcr>.freeze, ["~> 5.1"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.8"])
  end
end
