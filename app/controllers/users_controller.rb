class UsersController < ApplicationController
  skip_before_filter :user_required, :only => [:new, :create]
  skip_before_filter :session_required, :only => [:new, :create]
  skip_before_filter :confirmed_session_required, :only => [:new, :create]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:first_visit] = true # nice to know it is the first visit
      session[:user_id] = @user.id # log the user in
      redirect_to :track_sessions, :notice => 'Welcome'
    else
      flash.now.alert = 'Validation failed, please check and try again'
      render 'new'
    end
  end
end
