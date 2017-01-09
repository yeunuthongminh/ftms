class SyncServices::SynchronizeGoogle
  include SynchronizeTrainingSchedule

  def initialize args
    @auth = args[:auth]
    @auth.code = args[:code]
    @auth.fetch_access_token!
    @file = GoogleDrive.login_with_oauth(@auth.access_token).spreadsheet_by_url args[:link]
  end

  def list_sheets
    @file.worksheets.map &:title
  end
end
