# frozen_string_literal: true

require_relative "lib/sso_authenticator/version"

Gem::Specification.new do |spec|
  spec.name = "sso_authenticator"
  spec.version = SsoAuthenticator::VERSION
  spec.authors = ["adham90"]
  spec.email = ["hi@adham.dev"]
  spec.summary = "FoundersKit SSO Authenticator"
  spec.description = "SSO Authenticator for FoundersKit"
  spec.homepage = "https://github.com/founderskit/sso_authenticator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "httparty"
  spec.add_dependency "redis"
end
