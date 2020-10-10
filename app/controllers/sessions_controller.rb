class SessionsController < ApplicationController
  class PasswordMismatchError < StandardError; end

  def new
  end

  def create
    begin
      user = User.find_by!(email: params[:session][:email])
      raise PasswordMismatchError unless user.authenticate(params[:session][:password])
      flash[:notice] = "ログインが完了しました。"
      login(user)
      redirect_to "/"
    rescue
      flash[:danger] = "メールアドレスまたはパスワードが一致しませんでした。"
      redirect_to "/login"
    end
  end

  def destroy
    logout
    flash[:notice] = "ログアウトが完了しました。"
    redirect_to "/login"
  end
end
