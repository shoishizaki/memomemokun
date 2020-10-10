module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      # current_userが存在しない場合のみデータベースに問い合わせる
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def login?
    !current_user.nil?
  end
end
