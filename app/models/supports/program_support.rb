class Supports::ProgramSupport
  attr_reader :program

  def initialize args
    @program = args[:program]
  end

  def assigned_trainer_ids
    @assigned_trainer_ids ||= @program.trainer_programs.map &:user_id
  end

  def trainers
    @trainers ||= User.trainers
  end

  def trainer_programs_handler
    @trainer_programs_handler ||= Role.includes(:users, :user_roles)
      .find_by(name: Settings.roles.trainer).users.map do |trainer|
      TrainerProgram.unscoped
        .find_or_initialize_by user: trainer, program: @program
    end
  end

  def programs
    @programs ||= Program.all.collect {|program| [program.name, program.id]}
  end
end
