class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Current.user.groups.new(group_params)
    if @group.save
      @group.group_members.create!(user: Current.user)
      redirect_to @group
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @group = Group.find(params[:id])
    @applications = @group.applications.pending
  end

  def approve
    application = Application.find_by(group_id: params[:id], user_id: params[:user_id])
    application.update(status: :approved)
    application.group.group_members.create!(user: application.user)
    redirect_to group_path(application.group)
  end

  def reject
    application = Application.find_by(group_id: params[:id], user_id: params[:user_id])
    application.update(status: :rejected)
    redirect_to group_path(application.group)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end