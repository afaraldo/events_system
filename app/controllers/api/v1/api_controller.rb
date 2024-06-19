module Api
  module V1
    class ApiController < ApplicationController
      respond_to :json
      include Pundit::Authorization
      before_action :authenticate_user!

      protect_from_forgery with: :null_session
    end
  end
end
