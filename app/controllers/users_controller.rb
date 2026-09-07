class UsersController < ApplicationController
  def mypage
    @posts = Current.user.posts
  end

  def edit
    @user = Current.user
  end

  def update
    if Current.user.update(user_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def destroy
    Current.user.destroy
    terminate_session
    redirect_to signup_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email_address)
  end
end
