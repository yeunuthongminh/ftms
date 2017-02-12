class ActionDispatch::Routing::Mapper
  def draw routes_name
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users
  draw :api
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "dashboards#index"
end
