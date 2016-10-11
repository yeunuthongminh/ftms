class ResetPermissionExamJob < ApplicationJob
  queue_as :default

  def perform user_subject
    user_subject.update_attributes lock_for_create_exam: false
  end
end
