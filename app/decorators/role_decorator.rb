class RoleDecorator < Draper::Decorator
  delegate_all

  def function action, model_class
    function = functions.find_by action: action, model_class: model_class
    function.present? ? function.id : nil
  end
end
