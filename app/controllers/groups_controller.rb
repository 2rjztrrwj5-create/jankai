class GroupsController < ApplicationController
  def index
    @groups = Current.user.groups
  end

  def show
    @group = Group.find(params[:id])
  end
end