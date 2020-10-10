class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    unless login?
      flash[:warning] = "ログインが必要です。"
      redirect_to "/login"
    end
  end

  def no_authenticate_user
    if login?
      flash[:warning] = "すでにログインしています。"
      redirect_to "/"
    end
  end
end
