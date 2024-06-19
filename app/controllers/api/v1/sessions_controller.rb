module Api
  module V1
    class SessionsController < Devise::SessionsController
      respond_to :json
      protect_from_forgery with: :null_session

      def create
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        render json: { message: 'Logged in successfully.', user: resource, token: current_token }, status: :ok
      end

      def destroy
        sign_out(resource_name)
        render json: { message: 'Logged out successfully.' }, status: :ok
      end

      private

      def respond_with(resource, _opts = {})
        render json: resource
      end

      def current_token
        request.env['warden-jwt_auth.token']
      end
    end
  end
end
