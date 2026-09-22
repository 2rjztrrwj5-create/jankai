class ApplicationsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    if @group.applications.exists?(user: Current.user) || @group.users.include?(Current.user)
      redirect_to @group, alert: "既に申請済み、または参加済みです。"
    else
      @application = @group.applications.new(user: Current.user, status: :pending)
      @application.save
      redirect_to @group, notice: "参加申請を送信しました。"
    end
  end
end