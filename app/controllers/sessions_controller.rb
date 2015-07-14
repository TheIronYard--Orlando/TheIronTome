class SessionsController < ApplicationController
  include Login
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if User.count.zero?
      session[:user_id] = "temp"
      redirect_to admin_url
    elsif user and user.authenticate(params[:password])
      login(user)
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
