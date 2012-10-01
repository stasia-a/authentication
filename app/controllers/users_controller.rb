class UsersController < ApplicationController
  skip_before_filter :user_required, :only => [:new, :create]
  skip_before_filter :session_required, :only => [:new, :create]
  skip_before_filter :confirmed_session_required, :only => [:new, :create]
  skip_before_filter  :signed_in_user, :only => [:new, :create]
  before_filter :correct_user, :only => [:edit, :update ]

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end



  end

  private

  def signed_in_user
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
