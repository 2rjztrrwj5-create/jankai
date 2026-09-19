class UsersController < ApplicationController
  def mypage
    @posts = Current.user.posts
    @user = Current.user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = Current.user
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to mypage_path
    else
      render :edit, status: :unprocessable_entity
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
