class Supports::AssignUser
  attr_reader :course

  def initialize args
    @course = args[:course]
  end

  def trainees_assign
    @trainees ||= Trainee.available_of_course @course.id
  end

  def trainers_assign
    @trainers ||= User.not_trainees
  end

  def assigned_user_ids
    @assigned_user_ids ||= @course.user_courses.without_deleted.map &:user_id
  end

  %w(trainee trainer).each do |object|
    define_method "#{object}_courses_handler" do
      instance_variable_set "@#{object}_courses_handler",
        (
          send("#{object}s_assign").map do |user|
            Object.const_get("#{object}_course".classify).unscoped
              .find_or_initialize_by user: user, course: @course
          end
        )
    end
  end
end
