class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.create!(user_params)
      flash[:notice] = "ユーザー登録が完了しました。"
      redirect_to "/", status: 200
    rescue
      flash[:danger] = "ユーザーの登録に失敗しました。"
      redirect_to "/signup", status: 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
