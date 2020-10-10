class SessionsController < ApplicationController
  before_action :no_authenticate_user, {only: [:new, :create]}

  class PasswordMismatchError < StandardError; end

  def new
  end

  def create
    begin
      user = User.find_by!(email: params[:session][:email])
      raise PasswordMismatchError unless user.authenticate(params[:session][:password])
      flash[:success] = "ログインが完了しました。"
      login(user)
      redirect_to "/"
    rescue
      flash[:error] = "メールアドレスまたはパスワードが一致しませんでした。"
      redirect_to "/login"
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトが完了しました。"
    redirect_to "/login"
  end
end
