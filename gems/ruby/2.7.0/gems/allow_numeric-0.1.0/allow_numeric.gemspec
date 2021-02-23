
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "allow_numeric/version"

Gem::Specification.new do |spec|
  spec.name          = "allow_numeric"
  spec.version       = AllowNumeric::VERSION
  spec.authors       = ["Abhishek Kanojia"]
  spec.email         = ["abhishek.kanojia3193@gmail.com"]

  spec.summary       = %q{ This gem provides easy way to restrict numeric input to input fields using jquery. }
  spec.description   = %q{ This gem provides easy way to restrict numeric input to input fields using jquery and integrates with Rails asset pipeline for easy of use. }
  spec.homepage      = "https://github.com/abhikanojia/allow_numeric"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'jquery-rails', '~> 4.3'
end
