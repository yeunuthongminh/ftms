class Supports::RoleSupport
  attr_reader :role

  def initialize role
    @role = role
  end

  def presenter form
    @role_allocate_function_presenters_admin ||= AllocateFunctionPresenter.new(
      namespace: @namespace, role: @role, form: form).render
  end
end
