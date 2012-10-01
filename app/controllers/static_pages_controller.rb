class StaticPagesController < ApplicationController
  skip_before_filter :user_required, :session_required, :confirmed_session_required, :signed_in_user

  def home
  end

  def help
  end

  def main
  end
end
