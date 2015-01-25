class ApplicationController < ActionController::Base
  before_action :authorize
  rescue_from Exception, with: :handle_exceptions

  private
  def handle_exceptions(error)
    ErrorNotifier.failed(error).deliver
    logger.error error.message
    redirect_to store_url, notice: error.message
  end

  protected
  def authorize
    unless User.find(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
