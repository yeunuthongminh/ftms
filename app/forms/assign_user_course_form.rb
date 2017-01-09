class AssignUserCourseForm
  include InitUserSubject

  def initialize course, *args
    @course = course
    @user_courses = args
  end

  def users
    @users ||= User.available_of_course @course.id
  end

  def save
    user_courses = @user_courses.flatten
    user_course_ids = []
    user_courses.each do |user_course|
      user_course_ids.push(user_course["id"]) unless user_course["id"].blank?
    end
    ActiveRecord::Base.transaction do
      @course.user_courses.where.not(id: user_course_ids).try :destroy_all

      user_courses.each do |attr|
        user_course = if attr["id"].to_i != 0
            _user_course = UserCourse.with_deleted.find_by id: attr["id"]
            _user_course.update_attributes attr.except("id")
          else
            @course.user_courses.create attr.except("id")
          end
        init_user_subjects(user_course) if user_course.is_a?(TraineeCourse)
      end
      return true
    end
    false
  end

  def user_courses
    @user_courses ||= Array.new
  end

  private
  def init_user_subjects user_course
    create_user_subjects [user_course], @course.course_subjects, @course.id
  end
end
