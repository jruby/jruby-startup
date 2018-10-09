
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jruby/startup/version"

Gem::Specification.new do |spec|
  spec.name          = "jruby-startup"
  spec.version       = JRuby::Startup::VERSION
  spec.authors       = ["Charles Oliver Nutter"]
  spec.email         = ["headius@headius.com"]

  spec.summary       = %q{A set of utilities to improve the startup time of JRuby's command line}
  spec.homepage      = "https://github.com/jruby/jruby-startup"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
