$model_classes = (ActiveRecord::Base.connection.tables - %w[schema_migrations activities ckeditor_assets ar_internal_metadata tests project_stages functions programs role_functions trainer_programs user_functions])
                   .map{|model| model.classify.constantize}
