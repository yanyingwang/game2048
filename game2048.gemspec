require_relative 'lib/game2048/version'

Gem::Specification.new do |spec|
  spec.name          = "game2048"
  spec.version       = Game2048::VERSION
  spec.authors       = ["Yanying Wang"]
  spec.email         = ["yanyingwang1@gmail.com"]

  spec.summary       = %q{game2048}
  spec.description   = %q{game2048}
  spec.homepage      = "https://github.com/yanyingwang/game2048"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yanyingwang/game2048"
  spec.metadata["changelog_uri"] = "https://github.com/yanyingwang/game2048"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
