class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  rescue_from Exception, with: :handle_exceptions

  private
  def handle_exceptions(error)
    ErrorNotifier.failed(error).deliver_now
    logger.error error.message
    redirect_to store_url, notice: error.message
  end

  protected
  def authorize
    return if User.count.zero?
    if User.count && session[:user_id] == "temp"
      session.delete(:user_id)
      redirect_to store_url and return
    end

    if request.format != Mime::HTML
      authenticate_or_request_with_http_basic do |username, password|
        return false unless user = User.find_by_name(username)
        user.authenticate(password)
      end
    end


    unless User.find(session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] =
          "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
