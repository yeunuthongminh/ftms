module PolicyHelper

  def policy args
    object = args[:controller].classify
    namespace = @namespace.classify
    if @namespace == Settings.namespace_roles.trainee
      pundit_policy = "#{object}Policy"
    else
      pundit_policy = "#{namespace}::#{object}Policy".constantize
    end
    policy = pundit_policy.new current_user,
      controller: "#{@namespace}/#{args[:controller]}", action: args[:action]
    policy.send "#{args[:action]}?"
  end
end
