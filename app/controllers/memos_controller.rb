class MemosController < ApplicationController
  before_action :authenticate_user

  def index
    @user = current_user
    @index = Memo.where(user_id: @user.id)
    @memo_exist = @index.present?
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

  def edit
    @memo = Memo.find_by(id: params[:id])
  end

  def update
    begin
      @memo = Memo.find_by(id: params[:memo][:id])
      @memo.update!(memo_params)
      flash[:success] = "メモの編集が完了しました。"
      redirect_to "/memo"
    rescue
      flash[:warning] = "メモのカテゴリーを入力してください。"
      redirect_to memo_edit_path(id: params[:memo][:id])
    end
  end

  def destroy
    begin
      @memo = Memo.find(params[:id])
      @memo.destroy!
      flash[:success] = "メモを削除しました。"
      redirect_to "/memo"
    rescue
      flash[:error] = "原因不明のエラーが発生しました。"
      redirect_to "/memo"
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:category, :content, :user_id)
  end
end
