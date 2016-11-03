class Admin::ProgramsController < ApplicationController
  before_action :authorize
  before_action :find_program, only: [:edit, :update]
  before_action :load_data, only: :edit

  def index
    add_breadcrumb_index "programs"
  end

  def new
    @program = Program.new
    load_data
    add_breadcrumb_path "programs"
    add_breadcrumb_new "programs"
  end

  def create
    @program = Program.new params_programs
    if @program.save
      flash[:success] = flash_message "created"
      redirect_to admin_programs_path
    else
      load_data
      add_breadcrumb_path "programs"
      add_breadcrumb_new "programs"
      render :new
    end
  end

  def edit
    add_breadcrumb_path "programs"
    add_breadcrumb_edit "programs"
  end

  def update
    if @program.update_attributes params_programs
      flash[:success] = flash_message "updated"
      redirect_to admin_programs_path
    else
      load_data
      add_breadcrumb_path "programs"
      add_breadcrumb_edit "programs"
      render :edit
    end
  end

  def destroy
    if @program.destroy
      flash[:success] = flash_message "deleted"
    else
      flash[:error] = flash_message "not_deleted"
    end
    redirect_to admin_programs_path
  end

  private
  def params_programs
    params.require(:program).permit Program::ATTRIBUTES_PARAMS
  end

  def load_data
    @program_supports = Supports::Program.new program: @program
  end

  def find_program
    @program = Program.includes(trainer_programs: :user).find_by id: params[:id]
    if @program.nil?
      flash[:alert] = flash_message "not_find"
      redirect_to admin_programs_path
    end
  end
end
