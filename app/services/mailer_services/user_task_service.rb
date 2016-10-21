class MailerServices::UserTaskService
  attr_reader :args

  def initialize args
    @user_task = args[:user_task]
    @status = args[:status]
  end

  def perform
    user_task_history = @user_task.user_task_histories.create status: @status
  end
end
