class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      # 登録成功
      flash[:success] = 'ユーザーを登録しました。'      
      redirect_to root_url
    else
      #  登録失敗
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end

  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end