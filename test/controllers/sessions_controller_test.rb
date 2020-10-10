require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # 概要: ログインページにアクセスできることを確認
  # 期待値: 200が返ってくる
  test "should get login" do
    get login_url
    assert_response(200)
  end

  # 概要: 登録したユーザーで正常にログインできることを確認
  # 期待値: ユーザーがログインしていることを確認
  test "should login" do
    assert_equal(0, User.all.count)
    # 準備
    params = {
      email: "testtest@gmail.com",
      password: "testtest"
    }
    User.create!(params)
    assert_equal(1, User.all.count)

    get login_url
    params = {
      session: {
        email: "testtest@gmail.com",
        password: "testtest"
      }
    }
    post login_path, params: params
    assert(is_login?)
  end

  # 概要: メールアドレスが異なる時ログインできないことを確認
  # 期待値: ユーザーがログインできていないこと
  test "should not login when email address is wrong" do
    assert_equal(0, User.all.count)
    # 準備
    params = {
      email: "testtest@gmail.com",
      password: "testtest"
    }
    User.create!(params)
    assert_equal(1, User.all.count)

    get login_url
    params = {
      session: {
        email: "miss@gmail.com",
        password: "testtest"
      }
    }
    post login_path, params: params
    assert_not(is_login?)
  end

  # 概要: パスワードが異なる時ログインできないことを確認
  # 期待値: ユーザーがログインできていないこと
  test "should not login when email password is wrong" do
    assert_equal(0, User.all.count)
    # 準備
    params = {
      email: "testtest@gmail.com",
      password: "testtest"
    }
    User.create!(params)
    assert_equal(1, User.all.count)

    get login_url
    params = {
      session: {
        email: "testtest@gmail.com",
        password: "misspassword"
      }
    }
    post login_path, params: params
    assert_not(is_login?)
  end

  # 概要: 正常にログアウトできていることを確認
  # 期待値: ユーザーがログアウトできていること
  test "should logout" do
    # 準備でログインする
    assert_equal(0, User.all.count)

    params = {
      user: {
        email: "testtest@gmail.com",
        password: "testtest"
      }
    }

    post users_url, params: params
    assert(is_login?)

    delete logout_path
    assert_not(is_login?)
  end

end
