Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount ActionCable.server => "/cable"

  filter :locale
  devise_for :users, path: "auth",
    controllers: {sessions: "sessions", passwords: "passwords"},
    path_names: {sign_in: "login", sign_out: "logout"}

  namespace :admin do
    root "statistics#show", type: "total_trainees"
    resources :course_masters
    resources :courses do
      resources :subjects, only: :show
      resource :assign_trainers, only: [:edit, :update]
      resource :assign_trainees, only: [:edit, :update]
      resource :change_status_courses, only: :update
      resources :course_subjects, except: [:new, :show]
      resources :clone_courses, only: :create
    end
    resources :roles
    resources :subjects do
      resources :task_masters, only: :index
    end
    resources :course_subjects do
      resource :assign_project, only: :update
      resources :user_subjects, only: :update
      resources :tasks, except: :show
      resources :course_subject_requirement, only: :update
    end
    resources :users, except: :index do
      resource :stages, only: [:edit, :update]
      resources :change_roles, only: [:index, :create]
    end

    resources :trainee_evaluations, only: :index
    resources :evaluation_standards
    resources :evaluation_items
    resources :evaluation_templates

    patch "status_subject/:course_subject_id/:status" => "status_subjects#update",
      as: :status_subject
    resources :evaluation_check_lists
    get "/statistics/:type" => "statistics#show", as: :statistics_page
    resources :ranks
    resources :universities, except: :show
    resources :languages, except: :show
    resources :statuses, except: :show
    resources :trainee_types, except: :show
    resources :profiles
    resources :notes, except: :index
    resources :locations
    resources :feed_backs, only: :index
    resources :organization_charts, only: :index
    resources :training_managements, only: :index
    resources :projects do
      resources :project_requirements, except: [:new, :edit, :show], defaults: {format: :json}
    end
    resources :questions, except: :show
    resources :exams, only: :index
    resources :statistics, only: [:index, :create]
    resources :stages
    resources :programs, except: :destroy
    get "/programs/(:parent_id)/subprogram/new", to: "programs#new", as: :new_program
    resources :imports, only: [:index, :create]
    resources :user_courses, only: :update do
      resources :trainee_evaluations, except: [:index, :destroy]
    end
    resources :user_subjects do
      resources :trainee_evaluations, except: [:index, :destroy]
    end
    resources :synchronizes
    resources :categories
  end

  namespace :trainer do
    root "dashboard#index"
    resources :course_masters
    resources :courses do
      resources :subjects, only: :show
      resource :assign_trainers, only: [:edit, :update]
      resource :assign_trainees, only: [:edit, :update]
      resource :change_status_courses, only: :update
      resources :course_subjects, except: :new
      resources :clone_courses, only: :create
    end
    resources :subjects do
      resources :task_masters, only: :index
    end
    resources :users, except: :index do
      resource :evaluations
    end
    resources :feed_backs, only: :index

    resources :course_subjects do
      resources :user_subjects, only: :update
      resources :tasks, except: :show
    end
    resources :roles do
      resource :allocate_permissions
    end

    patch "status_subject/:course_subject_id/:status" => "status_subjects#update",
      as: :status_subject
    get "/statistics/:type" => "statistics#show", as: :statistics_page
    resources :evaluations, only: :index
    resources :evaluation_templates
    resources :ranks
    resources :notes, except: :index
    resources :universities, except: :show
    resources :statuses, except: :show
    resources :trainee_types, except: :show
    resources :locations
    resources :organization_charts, only: :index
    resources :training_managements, only: :index
    resources :projects
    resources :programs, except: :destroy
    resources :statistics, only: [:index, :create]
  end

  root "static_pages#home"

  resources :courses, only: [:show, :index] do
    resources :subjects, only: [:show]
  end

  resources :course_subjects
  resources :users, only: [:edit, :update, :show] do
    resource :profiles
  end

  resources :user_courses, only: [:show] do
    resources :subjects, only: [:show]
  end

  resources :chats, only: :index
  resources :messages, except: [:index, :show, :edit]
  resources :read_marks, only: :update
  resources :tasks, except: [:new, :edit]
  resources :user_subjects, only: :update
  resources :user_tasks, only: [:show, :update]
  resources :notifications, only: :index
  patch "update_notifications" => "notifications#update"
  resources :feed_backs, only: :create
  resources :filter_datas, only: [:index, :create]
  resources :exams, only: [:show, :index, :update]
  resources :calendars, only: :index
  resource :change_current_role_type, only: :update
end
