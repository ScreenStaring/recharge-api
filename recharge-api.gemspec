# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "recharge/version"

Gem::Specification.new do |spec|
  spec.name          = "recharge-api"
  spec.version       = Recharge::VERSION
  spec.authors       = ["Skye Shaw"]
  spec.email         = ["skye.shaw@gmail.com"]

  spec.summary       = %q{Client for ReCharge Payments API}
  spec.description   = %q{Client for ReCharge Payments recurring payments API for Shopify}
  spec.homepage      = "https://github.com/ScreenStaring/recharge-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata      = {
    "changelog_uri" => "https://github.com/ScreenStaring/recharge-api/blob/master/Changes",
    "bug_tracker_uri" => "https://github.com/ScreenStaring/recharge-api/issues",
    "documentation_uri" => "http://rdoc.info/gems/recharge-api",
    "source_code_uri"  => "https://github.com/ScreenStaring/recharge-api",
  }

  spec.add_dependency "class2", "~> 0.5.0"
  # Need this temporarily for deep_stringify_keys! until we break to_h String key return value
  spec.add_dependency "activesupport", "< 8"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
