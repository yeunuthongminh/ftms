module BreadcrumbHelper
  def add_breadcrumb_path resource
    add_breadcrumb t("breadcrumbs.#{resource}.all"),
      "#{@namespace}_#{resource}_path".to_sym
  end

  def add_breadcrumb_index resource
    add_breadcrumb t "breadcrumbs.#{resource}.all"
  end

  def add_breadcrumb_new resource
    add_breadcrumb t "breadcrumbs.#{resource}.new"
  end

  def add_breadcrumb_edit resource
    add_breadcrumb t "breadcrumbs.#{resource}.edit"
  end

  def add_breadcrumb_subject_task_masters
    add_breadcrumb t("breadcrumbs.subjects.task_masters")
  end

  def add_breadcrumb_subject_new_task
    add_breadcrumb t("breadcrumbs.subjects.new_task")
  end

  def add_breadcrumb_role_allocate_permissions
    add_breadcrumb t "breadcrumbs.roles.allocate_permissions"
  end
end
