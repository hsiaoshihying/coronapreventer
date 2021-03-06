module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    session[:user] = user.class.name
  end

  # 渡されたユーザーがログイン済みユーザーであればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id] && session[:user] == 'StoreUser'
      @current_user ||= StoreUser.find_by(id: session[:user_id])
    elsif session[:user_id] && session[:user] == 'CustomerUser'
      @current_user ||= CustomerUser.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def include_all?(array, array_compare)
    array_compare.each do |value|
        unless array.include?(value)
          return false
        end
    end
    return true
  end
end
