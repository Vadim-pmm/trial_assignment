class TasksController < ApplicationController

  skip_before_action :authenticate_user!, only: [:welcome_page]
  before_action :navigate_task, except: [:index, :index_archive, :new, :create]

  def welcome_page
  end

  def index
    if current_user.admin
        redirect_to new_task_path
    else
      if current_user.group_id != 1
          @tasks = Task.where('accepted NOT LIKE (?) AND group_id LIKE (?)',
                              true, current_user.group_id).order(updated_at: :desc)
        end
    end
  end

  def index_archive
    @tasks = Task.where(accepted: true).order(updated_at: :desc)
    render 'index'
  end

  def new
    @task = Task.new
    @tasks = Task.where('accepted NOT LIKE (?)', true).order(updated_at: :desc)
    @group_id = 1
    @list_of_groups = Group.all.map { |item| [item.name, item.id] }
  end

  def create
    if params[:task][:name].strip == ''
      flash[:danger] = "Task name should not be empty"
    else
        # не получается вызвать ppermitted отдельно для group_id,
        # поэтому затолкнем пока ее в одну структуру вместе с name и description
        params[:task][:group_id] = params[:group_id]

        task_ = Task.new(params_permitted)
        if task_.save
          flash[:notice] = 'Successfully created'
        else
          flash[:danger] = "Can't save to db"
        end
    end
    redirect_to new_task_path
  end

   def edit
     @list_of_groups = Group.where('name NOT LIKE (?)', 'undefined').map { |item| [item.name, item.id] }
     # У НЕназначенной задачи group_id = 1 undefined
     @group_id = 1
   end

  def update
    params[:task][:group_id] = params[:group_id]

    if @task.update(params_permitted)
      flash[:notice] = 'Successfully assigned'
    else
      flash[:danger] = "Can't save to db"
    end
    redirect_to new_task_path
  end

  def accept_task
    @task.update(accepted: true)
    redirect_to tasks_path
  end

  def decline_task
    @task.update(reported_at: nil)
    redirect_to tasks_path
  end

  def mark_finished
    @task.update(reported_at: DateTime.now)
    redirect_to tasks_path
  end


  private

  def params_permitted
    params.require(:task).permit(:group_id, :name, :description, :deadline)
  end

  def navigate_task
    @task = Task.find(params[:id])
  end

end
