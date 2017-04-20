class GroupsController < ApplicationController

  def new
    @groups = Group.where('name NOT LIKE (?)', 'undefined')
    @group = Group.new
  end

  def create
    if Group.create(params_permitted)
      flash[:notice] = 'Successfully created'
    else
      flash[:danger] = "Can't save to db"
    end
    redirect_to new_group_path
  end

  private

  def params_permitted
    params.require(:group).permit(:name)
  end

end
