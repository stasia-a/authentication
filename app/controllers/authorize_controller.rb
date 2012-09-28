class AuthorizeController < ApplicationController
  def new
  end

  def create
    @salt = params[:session][:salt]
    if token == session[:token]
      @user = User.where("email = ? OR login = ? ",params[:session][:email].downcase, params[:session][:login])
      redirect_to  @user
    else
      redirect_to '/signup'
    end
  end
end
