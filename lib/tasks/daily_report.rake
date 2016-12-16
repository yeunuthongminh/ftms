namespace :db do
  desc "TODO"
  task daily_report: :environment do
    Trainer.all.each do |trainer|
      if trainer.courses.any?
        DailyReportJob.perform_now DailyReportJob::MAIL_DAY, trainer.id
      end
    end
  end
end
