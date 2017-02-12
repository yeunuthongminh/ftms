module ApplicationHelper
  def full_title page_title = ""
    base_title = t "layouts.framgia"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def flash_message flash_type, *params
    if params.empty?
      t "flashs.messages.#{flash_type}", model_name: controller_name.classify
    else
      t "flashs.messages.#{flash_type}",
        models_name: params[0].join(", ") unless params[0].empty?
    end
  end
end
