class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      # ログイン成功
      flash[:success] = 'ログインに成功しました'
      redirect_to tasks_path
    else
      # ログイン失敗
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  private 
  
  # ログイン処理関数
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功なら、セッションにユーザーIDを保存する
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗なら何もせずにfalseを返す
      return false      
    end
    
    
  end
  
end
