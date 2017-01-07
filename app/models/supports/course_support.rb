class Supports::CourseSupport
  attr_reader :course, :program, :current_user

  def initialize args
    @current_user = args[:current_user]
    @course = args[:course]
    @namespace = args[:namespace]
    @program = args[:program]
    @filter_service = args[:filter_service]
  end

  def course_subjects
    @course_subjects ||= @course.course_subjects.includes(:subject, :user_subjects).order_position
  end

  %w(trainees trainers).each do |objects|
    define_method objects do
      instance_variable_set "@#{objects}",
        @course.send("#{objects}")
    end
  end

  def subjects
    @subjects ||= Subject.all
  end

  %w(languages locations programs).each do |objects|
    define_method objects do
      instance_variable_set "@#{objects}",
        objects.classify.constantize.all.collect {|object| [object.name,
        object.id]}
    end
  end

  def courses
    @courses = if @program
      program_ids = @program.self_and_descendants.collect &:id
      Course.in_programs(program_ids).includes :language, :location,
        :program, trainer_courses: :user
    elsif @current_user
      @current_user.courses.includes :language, :location, :program
    else
      Course.includes :language, :location, :program, trainer_courses: :user
    end
  end

  def filter_data_user
    @filter_data_user ||= @filter_service.user_filter_data
  end

  def course_presenters
    @course_presenters ||=  CoursePresenter.new(courses: courses,
      namespace: @namespace, program: @program).render
  end
end
