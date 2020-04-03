class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  
  # アクション定義
  # Prefix:tasks Verb:GET  
  def index
    #ログインユーザーに紐づくタスクのみ表示する
    @tasks = current_user.tasks
  end  
  
  # Prefix:none Verb:POST
  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_to @task
      
    else
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new      
      
    end
    
  end
  
  # Prefix:new_task Verb:GET
  def new
    @task = Task.new
  end
  
  # Prefix:edit_task Verb:GET
  def edit
    @task = Task.find(params[:id])    
  end
  
  # Prefix:task Verb:GET
  def show
    @task = Task.find(params[:id])
  end
  
  
  # Prefix:none Verb:PATCH(PUT)
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
      
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
      
    end
  end
  
  # Prefix:none Verb:DELETE  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
    
  end

  #プライベート関数定義
  private
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
    
end
