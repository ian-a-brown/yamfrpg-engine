# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

rails_version_file = File.join(__dir__, '../.rails-version')
rails_version = if Pathname.new(rails_version_file).exist?
                  File.read(rails_version_file)
                else
                  '7.1.3.2'
                end

Gem::Specification.new do |spec|
  spec.name        = 'yamfrpg-engine'
  spec.version     = '0.1.0'
  spec.authors     = ['Ian A. Brown']
  spec.email       = ['ianbrownfone@gmail.com']
  spec.homepage    = 'http://github.com/ian-a-brown/yamfrpg-engine.git'
  spec.summary     = 'Model and services engine for YAMFRPG.'
  spec.description = 'This engine contains the data models and supporting services for the YAMFRPG'
  spec.license     = 'MIT'

  spec.required_ruby_version = '~> 3.3.1'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'http://github.com/ian-a-brown/yamfrpg-engine.git'
  # spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'active_model_serializers'
  spec.add_dependency 'active_record_union'
  spec.add_dependency 'activerecord_where_assoc'
  spec.add_dependency 'bcrypt'
  spec.add_dependency 'composite_primary_keys'
  spec.add_dependency 'devise'
  spec.add_dependency 'devise-security'
  spec.add_dependency 'faker'
  spec.add_dependency 'omniauth-github'
  spec.add_dependency 'omniauth-google-oauth2'
  spec.add_dependency 'omniauth-rails_csrf_protection'
  spec.add_dependency 'pg'
  spec.add_dependency 'phonelib'
  spec.add_dependency 'pundit'
  spec.add_dependency 'rails', rails_version
  spec.add_dependency 'uuid'
  spec.add_dependency 'with_model'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
