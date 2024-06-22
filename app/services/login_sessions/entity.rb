# frozen_string_literal: true

module LoginSessions
  # Login entity record.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class Entity
    attr_reader :model,
                :name

    def initialize(model, model_alias = nil)
      @model = model
      @name = model.name.demodulize
      @name_underscore = modal_alias.to_s unless model_alias.nil?
    end

    def get_identifier_from_params_or_headers(controller)
      get_value_from_params_or_headers(controller, identifier_param_name, identifier_header_name)
    end

    def get_token_from_params_or_headers(controller)
      get_value_from_params_or_headers(controller, token_param_name, token_header_name)
    end

    def get_uuid_from_params_or_headers(controller)
      get_value_from_params_or_headers(controller, uuid_param_name, uuid_header_name)
    end

    def identifier
      if (custom_identifier = LoginSessions.identifiers[name_symbol])
        return custom_identifier.to_sym
      end

      :email
    end

    def identifier_header_name
      field_header_name(identifier)
    end

    def identifier_param_name
      field_param_name(identifier)
    end

    def name_underscore
      @name_underscore || name.underscore
    end

    def token_header_name
      field_header_name(:authentication_token)
    end

    def token_param_name
      field_param_name(:authentication_token)
    end

    def uuid_header_name
      field_header_name(:authentication_uuid)
    end

    def uuid_param_name
      field_param_name(:authentication_uuid)
    end

    private

    def field_header_name(field_name)
      if LoginSessions.header_names[name_symbol].presence &&
         (header_name = LoginSessions.header_names[name_symbol][field_name])
        return header_name
      end

      "X-#{name_underscore.camelize}-#{field_name.to_s.camelize}"
    end

    def field_param_name(field_name)
      :"#{name_underscore}_#{field_name}"
    end

    def get_value_from_params_or_headers(controller, param_name, header_name)
      if (header_value = controller.params[param_name].blank? &&
          controller.request.headers[header_name])
        controller.params[param_name] = header_value
      end

      controller.params[param_name]
    end

    def name_symbol
      name_underscore.to_s.to_sym
    end
  end
end
