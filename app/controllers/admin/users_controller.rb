class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "退会処理が完了しました。"
  end
end