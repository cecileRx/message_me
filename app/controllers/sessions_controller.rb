class SessionsController < ApplicationController
  before_action :not_already_logged, except: [:destroy]

  def new

  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to root_path
    else
      flash.now[:alert] = "There was something wrong with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

  private

  def not_already_logged
    if logged_in?
      flash[:alert] = "You are already logged in"
      redirect_to root_path
    end
  end

end


