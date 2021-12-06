# frozen_string_literal: true

require_relative "lib/glyptodont/version"

GITHUB_URL = "https://github.com/johnsyweb/glyptodont/"

Gem::Specification.new do |spec|
  spec.name          = "glyptodont"
  spec.version       = Glyptodont::VERSION
  spec.authors       = ["Pete Johns"]
  spec.email         = ["paj+github@johnsy.com"]

  spec.summary       = "A bit like `git grep 'T0D0'`, but better."  # .tr("0", "O")
  spec.description   = "Use this gem if you want to avoid deploying code to production without doing all of your to-dos"
  spec.homepage      = GITHUB_URL
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = GITHUB_URL
  spec.metadata["changelog_uri"] = "#{GITHUB_URL}blob/HEAD/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  %w[git rugged].each { |gem| spec.add_dependency(gem) }
end
