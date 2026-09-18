class Admin::SessionsController < Admin::BaseController
  allow_unauthenticated_admin_access only: %i[ new create ]

  def new
  end

  def create
    if admin = Admin.authenticate_by(params.permit(:email_address, :password))
      start_new_admin_session_for admin
      redirect_to admin_users_path, notice: "ログインしました。"
    else
      redirect_to admin_login_path, alert: "メールアドレスまたはパスワードが正しくありません。"
    end
  end

  def destroy
    terminate_admin_session
    redirect_to admin_login_path
  end
end