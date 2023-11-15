# frozen_string_literal: true

require_relative "lib/flespi"

Gem::Specification.new do |spec|
  spec.name = "flespi-ruby"
  spec.version = "1.0.0"
  spec.authors = ["Vladislav Kostikov"]
  spec.email = ["vlad@kostikov.ru"]

  spec.summary = "flespi.io"
  spec.homepage = "https://github.com/vladkostikov/flespi-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "json", ">= 1"
end