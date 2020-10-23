require 'test_helper'

class MemoTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: "test@test.com", password: "testtest")
    @memo = Memo.new(category: "テストカテゴリー", content: "テスト内容", user_id: @user.id)
  end

  # 概要: 問題無いパラメータを渡した際にはバリデーションに引っかからないことを確認
  # 期待値: モデルオブジェクトを作成できている
  test "should be valid" do
    assert @memo.valid?
  end

  # 概要: カテゴリーに値が入っていない時バリデーションに引っかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "should be not valid when category is nil" do
    @memo.category = nil
    assert_not @memo.valid?

    @memo.category = ""
    assert_not @memo.valid?

    @memo.category = "      "
    assert_not @memo.valid?
  end

  # 概要: user_idに値が入っていない時バリデーションに引っかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "should be not valid when user_id is nil" do
    @memo.user_id = nil
    assert_not @memo.valid?
  end


end
