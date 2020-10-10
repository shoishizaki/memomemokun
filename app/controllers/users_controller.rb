class UsersController < ApplicationController
  before_action :no_authenticate_user, {only: [:new, :create]}

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    begin
      @user = User.create!(user_params)
      login(@user)
      flash[:notice] = "ユーザー登録が完了しました。"
      redirect_to "/"
    rescue
      flash[:danger] = "ユーザーの登録に失敗しました。"
      redirect_to "/signup"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
