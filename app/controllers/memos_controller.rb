class MemosController < ApplicationController
  before_action :authenticate_user

  def index
    @user = current_user
    @index = Memo.where(user_id: @user.id)
    @memo = Memo.new
  end

  def create
    begin
      @memo = Memo.create!(memo_params)
      flash[:success] = "メモの作成が完了しました。"
      redirect_to "/memo"
    rescue
      flash[:warning] = "メモのカテゴリーを入力してください。"
      redirect_to "/memo"
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:category, :content, :user_id)
  end
end
