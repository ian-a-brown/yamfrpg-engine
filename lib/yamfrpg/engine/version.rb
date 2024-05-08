# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Module for handling the version number of YAMFRPG engine gem. The version number is defined in the gemspec.
    module Version
      version = Gem::Specification.load(File.expand_path('../../../yamfrpg-engine.gemspec', File.dirname(__FILE__)))
                                  .version
                                  .to_s
                                  .split('.')
                                  .map(&:to_i)

      MAJOR = version[0]
      MINOR = version[1]
      PATCH = version[2]
      STRING = "#{MAJOR}.#{MINOR}.#{PATCH}".freeze
    end

    VERSION = ::Yamfrpg::Engine::Version::STRING
  end
end
