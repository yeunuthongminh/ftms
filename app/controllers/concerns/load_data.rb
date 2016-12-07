module LoadData
  def load_user
    @user = User.includes(:profile).find_by id: params[:id]
    if @user.nil?
      flash[:alert] = flash_message "not_find"
      back_or_root
    end
  end

  ["course", "subject", "task", "user_task", "user_subject", "role"].each do |model|
    define_method "load_#{model}" do
      instance_variable_set "@#{model}", model.classify.constantize.find_by(id: params[:id])
      unless instance_variable_get "@#{model}"
        flash[:alert] = flash_message "not_find"
        back_or_root
      end
    end
  end

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    if @course_subject.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to @course
    end
  end

  def back_or_root
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end
end
