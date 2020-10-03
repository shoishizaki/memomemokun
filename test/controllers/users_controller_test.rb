require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # 概要: signupページにアクセスできることを確認
  # 期待値: 200が返ってくる
  test "should get new" do
    get signup_url
    assert_response(200)
  end

  # 概要: ユーザー登録できることを確認
  # 期待値: 200が返ってくる、DBの登録件数が一件ある、登録したユーザーのメールアドレスが一致
  test "should succsess signup" do
    # ユーザーが登録されていないことを確認
    assert_equal(0, User.all.count)

    params = {
      user: {
        email: "testtest@gmail.com",
        password: "testtest"
      }
    }

    post users_url, params: params
    assert_response(200)
    assert_equal(1, User.all.count)
    assert_equal("testtest@gmail.com", User.first.email)
  end

  # 概要: メールアドレスが適切では無い時にユーザー登録に失敗することを確認
  # 期待値: 500が返ってくる、DBに登録されていないことを確認
  test "should fail signup when email is not appropriate " do
    params = {
      user: {
        email: "testtestgmail.com",
        password: "testtest"
      }
    }

    post users_url, params: params
    assert_response(500)
    assert_equal(0, User.all.count)
  end

  # 概要: パスワードが適切では無い時にユーザー登録に失敗することを確認
  # 期待値: 500が返ってくる、DBに登録されていないことを確認
  test "should fail signup when password is not appropriate " do
    params = {
      user: {
        email: "testtest@gmail.com",
        password: "test"
      }
    }

    post users_url, params: params
    assert_response(500)
    assert_equal(0, User.all.count)
  end

end
