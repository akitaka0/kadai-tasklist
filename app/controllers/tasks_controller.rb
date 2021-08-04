class TasksController < ApplicationController
  before_action :require_user_logged_in
  def index
    if logged_in?
      @task = current_user.tasks.build  
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
    end
  end

  def show
    set_task
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスク が正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が作成されませんでした'
      render :new
    end
  end

  def edit
    set_task
    
  end

  def update
    set_task

    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
