class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  def index; end
end
