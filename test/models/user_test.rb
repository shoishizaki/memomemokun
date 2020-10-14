require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "test@test.com", password: "testtest")
  end

  # 概要: emailとpasswordに問題無いパラメータを渡した際にはバリデーションに引っかからないことを確認
  # 期待値: モデルオブジェクトを作成できている
  test "should be valid" do
    assert(@user.valid?)
  end

  # 概要: emailは必須であるためバリデーションにひっかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "email should be present" do
    @user.email = "     "
    assert_not(@user.valid?)
  end

  # 概要: emailはユニークであるためバリデーションにひっかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "email should be unique" do
    User.create(email: "test@test.com", password: "testtest")
    assert_not(@user.save)
  end

  # 概要: 無効なemailはバリデーションにひっかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not(@user.valid?, "#{invalid_address.inspect} should be invalid")
    end
  end

  # 概要: パスワードで空白はバリデーションにひっかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "password should be present (nonblank)" do
    @user.password = " " * 6
    assert_not(@user.valid?)
  end

  # 概要: パスワードで8文字以上はバリデーションにひっかかることを確認
  # 期待値: モデルオブジェクトを作成できる
  test "password should have a minimum length" do
    @user.password = "a" * 8
    assert(@user.valid?)
  end

  # 概要: パスワードで8文字未満はバリデーションにひっかかることを確認
  # 期待値: モデルオブジェクトを作成できていない
  test "password should have a 8 word" do
    @user.password = "a" * 7
    assert_not(@user.valid?)
  end

  # 概要: ユーザーが削除された時、メモも削除されることをを確認
  # 期待値: メモが削除されている
  test "should delete memo when user is deleted" do
    @user.save
    Memo.create(category: "テストカテゴリー", content: "テスト内容", user_id: @user.id)
    assert_equal(1, Memo.all.count)
    @user.destroy
    assert_equal(0, Memo.all.count)
  end
end
