class Supports::RoleSupport
  attr_reader :role, :filter_service

  def initialize role, filter_service
    @role = role
    @filter_service = filter_service
    @routes = routes(String "value")
  end

  def filter_data_user
    @filter_data_user ||= @filter_service.user_filter_data
  end

  def role_allocate_function_presenters role
    @role_allocate_function_presenters_admin ||= AllocateFunctionPresenter.new(routes_admin: routes("admin"),
      routes_trainer: routes("trainer"), routes_trainee: routes("trainee"),
      namespace: @namespace, role: role).render
  end

  def routes value
    @routes = []
    temp = Rails.application.routes.set.anchored_routes.map(&:defaults)
      .reject {|route| route[:internal] || check_route(route[:controller], value)}

    temp.pluck(:controller).uniq.each do |controller|
      @routes << Hash["controller".to_sym, controller, "actions".to_sym,
        temp.select {|route| route[:controller] == controller}.pluck(:action).uniq]
    end
    @routes
  end

  private
  def check_route route, value
    if value == "trainee"
      Settings.controller_names.each do |object|
        return true if route.include?(object) || route.include?("admin") || route.include?("trainer")
      end
      false
    else
      Settings.controller_names.each do
        return false if route.include?(value)
      end
      true
    end
  end
end
