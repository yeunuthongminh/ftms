class Admin::FilterDatasController < ApplicationController
  before_action :load_filter, only: [:index]
  before_action :load_dates
  # before_action :load_worksheet, only: [:index]

  def index
    @filter_type = params[:filter_type]
    @type = params[:type]
    @month = params[:month]
    @date = params[:date]

    if @type == "select_range_time"
      @range_select = params[:range_select]
      @type_select = params[:type_select]
      @filter_field = @type
    else
      data = JSON.parse(@current_filter.content) rescue []
      @filter_field = @month.nil? ? @type : [@type, @month].join("_")
      @filter = data["list_filter_select"][@filter_field] || [] rescue []
      @key_field = :key
      @value_field = :value
      case @type
      when "trainee_name"
        @resources = User.trainees.order(:name).pluck :name
      when "trainee_type"
        @key_field = :id
        @value_field = :user_type_name
        @resources = UserType.order(:name).pluck :name
      when "location"
        @key_field = :id
        @value_field = :location_name
        @resources = Location.order(:name).pluck :name
      when "graduation"
        @key_field = :id
        @value_field = :name
        @resources = []
      when "trainee_status"
        @key_field = :id
        @value_field = :status_name
        @resources = Status.order(:name).pluck :name
      when "university"
        @key_field = :id
        @value_field = :universitys_name
        @resources = University.order(:name).pluck :name
      when "trainer"
        @key_field = :trainer
        @value_field = :trainer
        @resources = User.trainers.order(:name).pluck :name
      when "current_progress"
        @key_field = :current_progress
        @value_field = :current_progress
        @resources = Subject.order(:name).pluck :name
      when "start_training_date"
        @key_field = :start_training_date
        @value_field = :start_training_date
        @resources = Profile.order(:start_training_date).pluck(:start_training_date).uniq.compact
      when "leave_date"
        @key_field = :leave_date
        @value_field = :leave_date
        @resources = Profile.order(:leave_date).pluck(:leave_date).uniq.compact
      when "finish_training_date"
        @key_field = :finish_training_date
        @value_field = :finish_training_date
        @resources = Profile.order(:finish_training_date).pluck(:finish_training_date).uniq.compact
      when "contract_date"
        @key_field = :contract_date
        @value_field = :contract_date
        @resources = Profile.order(:contract_date).pluck(:contract_date).uniq.compact
      when "ready_for_project"
        @key_field = :ready_for_project
        @value_field = :ready_for_project
        @resources = [t("profiles.columns.ready_for_project.ready"),
          t("profiles.columns.ready_for_project.not_ready")]
      when "programming_language"
        @key_field = :id
        @value_field = :programming_language_name
        @resources = ProgrammingLanguage.order(:name).pluck :name
      when "working_day"
        @resources = Profile.order(:working_day).pluck(:working_day).uniq.compact
        @blank = @type == "working_day"
        @key_field = :working_day
        @value_field = :working_day
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    @filter = current_user.filters.find_or_create_by filter_type: load_filter_type,
      target_id: filter_params[:target_id], target_params: filter_params[:target_params]
    respond_to do |format|
      if @filter.update_attributes filter_params
        format.json {render json: {content: JSON.parse(@filter.content)}}
      else
        format.json {render json: :fail}
      end
    end
  end

  private
  def load_filter_type
    Filter.filter_types[params[:filter][:filter_type]]
  end

  def filter_params
    params.require(:filter).permit :user_id, :content, :target_id, :is_turn_on, :target_params
  end

  def load_filter
    @filter_type = params[:filter_type]
    return if @filter_type.nil? || !Filter.filter_types.keys.include?(@filter_type)
    @current_filter = current_user.filters.send(@filter_type).try :first
  end

  def filter_data column
    if column == "rank"
      @price_histories.map do |price|
        price.rank_name.to_i if price.rank_name.present?
      end.compact.uniq.sort
    elsif column == "ratio"
      @price_histories.map{|price| price.ratio}.compact.uniq.sort
    else
      @price_histories.map do |price|
        price.try(column) || price.employee.try(column)
      end.compact.uniq.sort
    end
  end

  def load_price_history_resources field, includes = nil
    @price_histories = @project.price_histories.includes(includes)
      .reject{|price_history| price_history.is_reject?}
    @resources = filter_data field
  end

  def load_statistic_resources field
    statistic_decorator = StatisticDecorator.new @month.to_date, current_user
    statistic_data = statistic_decorator.statistic
    @resources = statistic_data[:divisions].map do |division|
      division[:projects].map {|project| project[field]}
    end.flatten.compact.uniq.sort
  end

  def load_assignee_resources field, is_number = false
    @resources = CachingService.new([@month.to_date], current_user).assignees.map do |assignee|
      if is_number
        eval(assignee[@month][field.to_s]) rescue nil
      else
        assignee[@month][field.to_s]
      end
    end.compact.uniq.sort
  end

  def load_dates
    @dates = []
    @range_select = params[:range_time_values] ||
      params[:range_time_select] || params[:edit_range_time_values] ||
      Date.today.strftime("%Y-%m")
    param_date = params[:range_time_values] ||
      params[:edit_range_time_values] || params[:range_time_select]
    begin
      @dates = param_date.split(";").map{|date| Date.strptime(date,"%Y-%m")}.sort
    rescue
    end
    @dates << Date.today.beginning_of_month if @dates.blank?
  end

  def load_worksheet
    @worksheet = Worksheet.new(@dates, current_user).array
  end
end
