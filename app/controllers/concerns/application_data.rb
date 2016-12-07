module ApplicationData
  def init_feedback
    @feed_back = FeedBack.new
  end

  def load_namespace
    @namespace = self.class.parent.to_s.downcase
    @namespace = Settings.namespace_roles.trainee if @namespace == "object"
  end

  def to_do_lists
    @to_do_lists = current_user.user_tasks if user_signed_in? && current_user.trainee?
  end

  def load_root_path
    if current_user.nil?
    elsif current_user.is_admin? && @namespace == Settings.namespace_roles.admin
      add_breadcrumb I18n.t("breadcrumbs.paths"), "/admin"
    elsif current_user.is_trainer? && @namespace == Settings.namespace_roles.trainer
      add_breadcrumb I18n.t("breadcrumbs.paths"), "/trainer"
    else
      add_breadcrumb I18n.t("breadcrumbs.paths"), :root_path
    end
  end

  def redirect_if_object_nil object
    if object.nil?
      flash[:alert] = flash_message "not_find"
      back_or_root
    end
  end
end
