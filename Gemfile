source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0.1"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "react_on_rails", "~> 6"
gem "foreman"
gem "bootstrap-sass", "3.2.0.0"
gem "bootstrap-datepicker-rails"
gem "sdoc", "~> 0.4.0", group: :doc
gem "devise"
gem "simple_token_authentication"
gem "paranoia"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "delayed_job_active_record"
gem "sidekiq"
gem "whenever", require: false
gem "i18n-js", ">= 3.0.0.rc11"
gem "public_activity"
gem "ckeditor"
gem "carrierwave"
gem "mini_magick"
gem "breadcrumbs_on_rails"
gem "exception_notification"
gem "business_time"
gem "pundit"
gem "activerecord-import"
gem "closure_tree"
gem "redis", "~> 3.0"
gem "redis-namespace"
gem "redis-rails"
gem "redis-rack-cache", git: "git://github.com/jodosha/redis-rack-cache.git"
gem "flexslider-rails"
gem "config"
gem "wicked_pdf"
gem "wkhtmltopdf-binary"
gem "font-awesome-rails"
gem "pundit"

group :development, :test do
  gem "spring"
  gem "pry"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rack-mini-profiler"
  gem "pry-rails"
  gem "pry-byebug"
  gem "fabrication"
  gem "web-console", "~> 2.0"
  gem "letter_opener"
  gem "faker"
  gem "i18n-tasks", "~> 0.8.7"
  gem "rspec-rails", "~> 3.0"
  gem "bullet"
  gem "railroady"
  gem "figaro"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "mini_racer", platforms: :ruby
