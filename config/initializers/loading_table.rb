$model_classes = (ActiveRecord::Base.connection.tables - %w[schema_migrations activities ckeditor_assets ar_internal_metadata tests role_functions user_functions])
                   .map{|model| model.classify.constantize}
