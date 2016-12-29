module FilterHelper
  def load_function
    resourses = Function.pluck(:model_class, :action)
    @resourses = []
    resourses.reject{|object| (object[1].include? ("read")) ||
      (object[1].include? ("destroy")) }.each do |object|
      obj = object[0]
      obj = obj.split("/")
      if obj.length == 2
        obj[0] = obj[0].capitalize
        obj[1] = obj[1].capitalize
      else
        obj.prepend("Trainee")
      end
      @resourses << (obj[0]+ " "+object[1]+ " " +obj[1])
    end
    return @resourses
  end

  def load_namespace
    resourses = Function.pluck(:model_class)
    @resourses = []
    resourses.each do |obj|
      obj = obj.split("/")
      if obj.length == 2
        @resourses << obj[0].capitalize
      end
    end
    return @resourses.uniq
  end
end
