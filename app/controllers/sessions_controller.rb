class SessionsController < ApplicationController
  def new
    MortalToken.secret = 'asdf092$78roasdjfjfaklmsdadASDFopijf98%2ejA#Df@sdf'
    token = MortalToken.new
    @hash = token.hash
    @salt = token.salt
  end

  def create
    user = User.where("email = ? OR login = ? ",params[:session][:email].downcase, params[:session][:login])
    if user
     redirect_to '/authorize/new'
    end
  end

  def destroy

  end
end
