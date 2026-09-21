class ApplicationsController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @application = @group.applications.new(user: Current.user, status: :pending)
    @application.save
    redirect_to @group
  end
end