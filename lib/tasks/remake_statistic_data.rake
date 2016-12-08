namespace :db do
  desc "Add data to table statistics"
  task remake_statistic_data: :environment do
    puts "Load all stages"
    Stage.all.each do |stage|
      instance_variable_set("@#{stage.name.downcase.gsub(" ", "_")}", stage)
    end

    puts "Update to zero"
    Statistic.update_all total_trainee: 0

    puts "Remake statistic data..."
    Profile.includes(:user_type, :language, :location, :stage).each do |profile|
      UserType.all.each do |user_type|
        Language.all.each do |language|
          Location.all.each do |location|
            if profile.start_training_date
              statistic = Statistic.find_or_create_by month: profile.start_training_date.to_date.beginning_of_month,
                user_type: user_type, language: language,
                location: location, stage: @in_education
              if profile.user_type == user_type && profile.language == language &&
                profile.stage == @in_education && profile.location == location
                statistic.total_trainee += 1
                statistic.save
              end
            elsif profile.leave_date
              statistic = Statistic.find_or_create_by month: profile.leave_date.to_date.beginning_of_month,
                user_type: user_type, language: language,
                location: location, stage: @resigned
              if profile.user_type == user_type && profile.language == language &&
                profile.stage == @resigned && profile.location == location
                statistic.total_trainee += 1
                statistic.save
              end
            elsif profile.join_div_date
              statistic = Statistic.find_or_create_by month: profile.join_div_date.to_date.beginning_of_month,
                user_type: user_type, language: language,
                location: location, stage: @joined_div
              if profile.user_type == user_type && profile.language == language &&
                profile.stage == @joined_div && profile.location == location
                statistic.total_trainee += 1
                statistic.save
              end
            elsif profile.away_date
              statistic = Statistic.find_or_create_by month: profile.away_date.to_date.beginning_of_month,
                user_type: user_type, language: language,
                location: location, stage: @away
              if profile.user_type == user_type && profile.language == language &&
                profile.stage == @away && profile.location == location
                statistic.total_trainee += 1
                statistic.save
              end
            end
          end
        end
      end
    end

    puts "Finish add data to table statistics"
  end
end
