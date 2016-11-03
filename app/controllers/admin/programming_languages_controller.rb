class Admin::ProgrammingLanguagesController < ApplicationController
  before_action :authorize
  before_action :load_programming_language, except: [:index, :new, :create]

  def index
    @programming_languages = ProgrammingLanguage.all
  end

  def new
    @programming_language = ProgrammingLanguage.new
  end

  def create
    @programming_language = ProgrammingLanguage.new programming_language_params
    respond_to do |format|
      if @programming_language.save
        flash.now[:success] = flash_message "created"
        format.html{redirect_to admin_programming_languages_path}
      else
        flash.now[:failed] = flash_message "not_created"
        format.html{render :new}
      end
      format.js
    end
  end

  def edit
  end

  def update
    if @programming_language.update_attributes programming_language_params
      flash[:success] = "updated"
    else
      flash[:failed] = "not_updated"
      render :edit
    end
    redirect_to admin_programming_languages_path
  end

  def destroy
    if @programming_language.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:failed] = flash_message "not_deleted"
    end
    redirect_to admin_programming_languages_path
  end

  private
  def programming_language_params
    params.require(:programming_language).permit ProgrammingLanguage::ATTRIBUTES_PARAMS
  end

  def load_programming_language
    @programming_language = ProgrammingLanguage.find_by id: params[:id]
    unless @programming_language
      redirect_to admin_programming_languages_path
      flash[:alert] = flash_message "not_find"
    end
  end
end
