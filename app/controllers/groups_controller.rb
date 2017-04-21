class GroupsController < ApplicationController

  def new
    @groups = Group.where('name NOT LIKE (?)', 'undefined')
    @group = Group.new
  end

  def create
    group_ = Group.create(params_permitted)
    if group_.valid? && group_.save
      flash[:notice] = 'Successfully created'
    else
      flash[:danger] = 'Check the name'
    end
    redirect_to new_group_path
  end


  def destroy
    @group = Group.find(params[:id])
    @group.destroy if @group.can_be_destroyed?

    redirect_to 'new'
  end
  private

  def params_permitted
    params.require(:group).permit(:name)
  end

end
