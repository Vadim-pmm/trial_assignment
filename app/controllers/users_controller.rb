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
    user_ = User.find(params[:id])
    if user_.update(params_permitted)
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = "Can't save to db"
    end
    redirect_to users_path
  end

  def params_permitted
    params.require(:user).permit(:group_id)
  end

end
