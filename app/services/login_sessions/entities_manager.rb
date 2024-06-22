# frozen_string_literal: true

require_relative 'entity'

module LoginSessions
  # Login manager for login entities.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class EntitiesManager
    def find_or_create_entity(model, model_alias = nil)
      @entities ||= {}
      @entities[model.name] ||= Entity.new(model, model_alias)
    end
  end
end
