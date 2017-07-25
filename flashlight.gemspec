# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flashlight/version'

Gem::Specification.new do |spec|
  spec.name          = "flashlight"
  spec.version       = Flashlight::VERSION
  spec.authors       = ["Sergio Bayona"]
  spec.email         = ["sbayona@martianinteractive.com"]
  spec.summary = "Flash messages for Rails"
  spec.description   = <<EOT
flashlight displays your rails flash messages. Works with old flashion page loads and AJAX.
EOT
  spec.homepage      = "https://github.com/martianinteractive/flashlight"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 5.1.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
