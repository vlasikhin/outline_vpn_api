# frozen_string_literal: true

require_relative "lib/outline_vpn_api/version"

Gem::Specification.new do |spec|
  spec.name = "outline_vpn_api"
  spec.version = OutlineVpnApi::VERSION
  spec.authors = ["Pavel Vlasikhin"]
  spec.email = ["pavel.vlasikhin@gmail.com"]

  spec.summary = "Ruby API wrapper for Outline VPN Server"
  spec.description = "Ruby API wrapper for Outline VPN Server https://getoutline.org/"
  spec.homepage = "https://github.com/vlasikhin/outline_vpn_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(
        *%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile]
      )
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("httparty")
  spec.metadata["rubygems_mfa_required"] = "true"
end
