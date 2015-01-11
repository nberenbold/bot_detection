# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bot_detection/version'

Gem::Specification.new do |spec|
  spec.name          = "bot_detection"
  spec.version       = BotDetection::VERSION
  spec.authors       = ["Nils Berenbold"]
  spec.email         = ["nils.berenbold@gmail.com"]
  spec.summary       = %q{Detects Search Engine crawlers by reverse DNS lookups.}
  spec.homepage      = "http://www.nilsberenbold.de"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "public_suffix", "~> 1.4.6"

  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
