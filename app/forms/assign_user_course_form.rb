class AssignUserCourseForm
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

    @course.user_courses.where.not(id: user_course_ids).try :destroy_all

    user_courses.each do |attr|
      if attr["id"].to_i != 0
        user_course = UserCourse.with_deleted.find_by id: attr["id"]
        user_course.update_attributes attr.except("id")
      else
        @course.user_courses.create attr.except("id")
      end
    end
  end

  def user_courses
    @user_courses ||= Array.new
  end
end
