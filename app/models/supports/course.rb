class Supports::Course
  attr_reader :course

  def initialize course
    @course = course
  end

  def course_subjects
    @course_subjects ||= @course.course_subjects.includes(:subject).order_position
  end

  %w(trainees trainers).each do |objects|
    define_method objects do
      instance_variable_set "@#{objects}", @course.send("load_#{objects}")
    end
  end

  def groups
    @groups ||= Group.group_of_user_in_course @course.id
  end
end
