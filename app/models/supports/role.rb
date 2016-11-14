class Supports::Role
  attr_reader :role, :filter_service

  def initialize role, filter_service
    @role = role
    @filter_service = filter_service
    @routes = routes
  end

  def filter_data_user
    @filter_data_user ||= @filter_service.user_filter_data
  end

  def role_allocate_function_presenters role
    @role_allocate_function_presenters ||= AllocateFunctionPresenter.new(routes: routes,
      namespace: @namespace, role: role).render
  end

  def routes
    @routes = []
    temp = Rails.application.routes.set.anchored_routes.map(&:defaults)
      .reject {|route| route[:internal] || check_route(route[:controller])}

    temp.pluck(:controller).uniq.each do |controller|
      @routes << Hash["controller".to_sym, controller, "actions".to_sym,
        temp.select {|route| route[:controller] == controller}.pluck(:action).uniq]
    end
    @routes
  end

  private
  def check_route route
    Settings.controller_names.each do |object|
      return true if route.include? object
    end
    false
  end
end
