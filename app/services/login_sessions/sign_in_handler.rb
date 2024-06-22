# frozen_string_literal: true

module LoginSessions
  # Handler for sign in of a login session after successful token authentication.
  # This code is based on the gem simple_token_authentication (https://github.com/gonzalo-bulnes/simple_token_authentication)
  class SignInHandler
    include Singleton

    def sign_in(controller, record, *)
      integrate_with_devise_trackable!(controller)

      controller.send(:sign_in, record, *)
    end

    private

    def integrate_with_devise_trackable!(controller)
      controller.request.env['devise_skip_trackable'] = LoginSessions.skip_devise_trackable
    end
  end
end
