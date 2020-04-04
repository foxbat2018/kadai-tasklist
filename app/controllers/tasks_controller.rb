class TasksController < ApplicationController
  include TasksHelper
  
  before_action :require_user_logged_in, only: [:index, :show, :edit]
  before_action :get_user_task, only: [:edit, :show, :update, :destroy]
  
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
  end
  
  # Prefix:task Verb:GET
  def show
  end
  
  
  # Prefix:none Verb:PATCH(PUT)
  def update
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
  
  def get_user_task
    @task = Task.find_by(id: params[:id])
    # 指定されたタスクがログイン中ユーザーのものでなければタスク一覧に飛ばす
    unless current_user_task?(current_user, @task)
      flash[:danger] = 'ログイン中ユーザー以外のタスクが指定されました。'
      redirect_to tasks_url
    end
  end
  
end
