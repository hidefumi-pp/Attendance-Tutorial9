class UsersController < ApplicationController
  befor_action :set_user, only:[:show, :edit, :update]
  befor_action :logged_in_user, only:[:show, :edit, :update]
  befor_action :correct_user, only:[:edit, :update]
  
  def show
    
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # 保存成功後、ログインします。
      flash[:success] = '新規作成に成功しました！'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
  # paramasハッシュからユーザーを取得します。
  def set_user
    @user = User.find(paramas[:id])
  end
    
  
  # ログイン済のユーザーか確認します。
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  # アクセスしたユーザーが現在のユーザーか確認します。
  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end
  
  
  
end
