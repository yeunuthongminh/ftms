module PolicyHelper

  def policy args
    url = Rails.application.routes.recognize_path args
    object = url[:controller].classify
    pundit_policy = "#{object}Policy".constantize
    policy = pundit_policy.new current_user,
      controller: url[:controller], action: url[:action]
    policy.send "#{url[:action]}?"
  end

  def policy_with_method args
    url = Rails.application.routes.recognize_path args[:url]
    object = url[:controller].classify
    pundit_policy = "#{object}Policy".constantize
    policy = pundit_policy.new current_user,
      controller: url[:controller], action: args[:action]
    policy.send "#{args[:action]}?"
  end

  def policy_with_multi_path multi_paths
    multi_paths.each do |path|
      path = path.constantize.table_name.to_sym
      url = eval("#{@namespace}_#{path}_path")
      if policy url
        return true
      end
    end
    false
  end

  def policy_none_model multi_paths
    multi_paths.each do |path|
      url = eval("#{@namespace}_#{path}_path")
      if policy url
        return true
      end
    end
    false
  end
end
