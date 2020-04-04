module TasksHelper
  def current_user_task?(user, task)
    # タスクがnilでない、かつ、ユーザーIDがログイン中のユーザーの場合trueを返す
    task && task.user_id == user.id ? true : false
  end
end
