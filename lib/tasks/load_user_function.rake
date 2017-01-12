namespace :db do
  desc "remake database data"
  task load_user_function: :environment do

    puts "create function for admin"
    admins = []
    Admin.all.each do |admin|
      Function.all.each do |function|
        admins << UserFunction.new(function: function, user: admin, type: "AdminFunction")
      end
    end
    UserFunction.import admins

    puts "create function for trainee"
    trainees = []
    Trainee.all.each do |trainee|
      Function.where("model_class NOT LIKE ?", "%/%").each do |function|
        trainees << UserFunction.new(function: function, user: trainee, type: "TraineeFunction")
      end
    end
    UserFunction.import trainees

    puts "create function for trainer"
    trainers = []
    Trainer.all.each do |trainer|
      Function.where("model_class LIKE ?", "trainer/%").each do |function|
        trainers << UserFunction.new(function: function, user: trainer, type: "TrainerFunction")
      end
    end
    UserFunction.import trainers
  end
end
