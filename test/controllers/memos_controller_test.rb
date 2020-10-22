require 'test_helper'

class MemosControllerTest < ActionDispatch::IntegrationTest
  # 概要: メモページにアクセスできることを確認
  # 期待値: 200が返ってくる
  test "should get memo page" do
    # メモページはログイン状態でしかアクセスできないのでログインする
    login
    get memo_url
    assert_response(200)
  end

  # 概要: ログインしていない時にメモページにアクセスできないことを確認
  # 期待値: 302が返ってくる
  test "should not get memo page" do
    get memo_url
    assert_response(302)
  end

  # 概要: メモが作成できることを確認
  # 期待値: 新規のメモが作成されている
  test "should create memo" do
    # メモはログイン状態でしかアクセスできないのでログインする
    login
    assert_equal(0, Memo.all.count)
    params = {
      memo: {
        category: "テストカテゴリー",
        content: "test",
        user_id: User.first.id
      }
    }
    post memos_url, params: params

    assert_equal(1, Memo.all.count)
    assert_equal("テストカテゴリー", Memo.first.category)
    assert_equal("test", Memo.first.content)
  end

  # 概要: カテゴリーが入っていない時、メモが登録されていないことを確認
  # 期待値: 新規のメモが作成されていない
  test "should not create memo when category is nil" do
    # メモはログイン状態でしかアクセスできないのでログインする
    login
    assert_equal(0, Memo.all.count)
    params = {
      memo: {
        category: nil,
        content: "test",
        user_id: User.first.id
      }
    }
    post memos_url, params: params

    assert_equal(0, Memo.all.count)
  end

  # 概要: メモを削除できることを確認
  # 期待値: メモが削除されていることを確認
  test "should delete memo" do
    # メモはログイン状態でしかアクセスできないのでログインする
    login
    assert_equal(0, Memo.all.count)
    params = {
      memo: {
        category: "テストカテゴリー",
        content: "test",
        user_id: User.first.id
      }
    }
    post memos_url, params: params

    assert_equal(1, Memo.all.count)

    memo_id = Memo.first.id
    delete memos_url, params: {id: memo_id}
    assert_equal(0, Memo.all.count)
  end

  # 概要: メモが更新できることを確認
  # 期待値: メモが更新されている
  test "should update memo" do
    # メモはログイン状態でしかアクセスできないのでログインする
    login
    assert_equal(0, Memo.all.count)
    params = {
      memo: {
        category: "テストカテゴリー",
        content: "test",
        user_id: User.first.id
      }
    }
    post memos_url, params: params

    assert_equal(1, Memo.all.count)
    assert_equal("テストカテゴリー", Memo.first.category)
    assert_equal("test", Memo.first.content)

    params[:memo][:category] = "編集カテゴリー"
    params[:memo][:content] = "編集編集"
    params[:memo][:id] = Memo.first.id

    patch memo_url, params: params
    assert_equal(1, Memo.all.count)
    assert_equal("編集カテゴリー", Memo.first.category)
    assert_equal("編集編集", Memo.first.content)
  end

  # 概要: カテゴリーが入っていない時メモが更新されないことを確認
  # 期待値: メモが更新されていない
  test "should not update memo" do
    # メモはログイン状態でしかアクセスできないのでログインする
    login
    assert_equal(0, Memo.all.count)
    params = {
      memo: {
        category: "テストカテゴリー",
        content: "test",
        user_id: User.first.id
      }
    }
    post memos_url, params: params

    assert_equal(1, Memo.all.count)
    assert_equal("テストカテゴリー", Memo.first.category)
    assert_equal("test", Memo.first.content)

    params[:memo][:category] = ""
    params[:memo][:content] = "編集編集"
    params[:memo][:id] = Memo.first.id

    patch memo_url, params: params
    assert_equal(1, Memo.all.count)
    assert_equal("テストカテゴリー", Memo.first.category)
    assert_equal("test", Memo.first.content)
  end
end
