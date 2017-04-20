class UsersController < ApplicationController
  def index
    @users = User.where('admin NOT LIKE (?)', true)
  end

  def edit
    @user = User.find(params[:id])
    #@group = Group.find(@user.group_id)
    @list_of_groups = Group.all.map { |item| [item.name, item.id] }
  end

  def update
    a=11
    user = User.find(params[:id])
    if user.update(params_permitted)
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = "Can't save to db"
    end
    redirect_to users_path
  end

  def destroy
  end

  def params_permitted
    params.permit(:group_id)
  end

end
