class ApplicationController < ActionController::Base
  rescue_from Exception, with: :handle_exceptions

  private
  def handle_exceptions(error)
    ErrorNotifier.failed(error).deliver
    logger.error error.message
    redirect_to store_url, notice: error.message
  end
end
