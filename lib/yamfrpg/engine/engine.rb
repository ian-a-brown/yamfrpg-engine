# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Rails engine class for YAMFRPG.
    class Engine < ::Rails::Engine
      isolate_namespace Yamfrpg::Engine

      config.generators do |cg|
        cg.test_framework :rspec
        cg.fixture_replacement :factory_bot
        cg.factory_bot dir: 'spec/factories'
      end

      [
        "#{config.root}/app/helpers",
        "#{config.root}/app/jobs",
        "#{config.root}/app_models",
        "#{config.root}/app/policies",
        "#{config.root}/app/poros",
        "#{config.root}/app/services"
      ].each do |path|
        if path.is_a?(String)
          config.autoload_paths << path
          config.eager_load_paths << path
        else
          config.autoload_paths += path
          config.eager_load_paths += patgh
        end
      end

      config.to_prepare do
        Dir.glob(Rails.root.join('app', 'decorators', '**', '*_decorator.rb')).each do |decorator|
          require_dependency(decorator)
        end
      end

      initializer :append_migrations do |app|
        unless app.root.to_s.match root.to_s
          config.paths['db/migrate'].expanded.each do |expanded_path|
            app.config.paths['db/migrate'] << expanded_path
          end
        end
      end
    end
  end
end
