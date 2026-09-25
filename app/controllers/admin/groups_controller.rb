class Admin::GroupsController < Admin::BaseController
  def index
    @groups = Group.all
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: "グループを削除しました。"
  end
end