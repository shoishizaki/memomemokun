class ApplicationController < ActionController::Base
  include SessionsHelper

  def authenticate_user
    unless login?
      flash[:notice] = "ログインが必要です。"
      redirect_to "/login"
    end
  end

  def no_authenticate_user
    if login?
      flash[:notice] = "すでにログインしています。"
      redirect_to "/"
    end
  end
end
