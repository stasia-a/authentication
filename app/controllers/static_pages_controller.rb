class StaticPagesController < ApplicationController
  skip_before_filter :confirmed_session_required , :signed_in_user

  def home
  end

  def help
  end

  def signup
  end
end
