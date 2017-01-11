class ImportServices::ImportProject < ImportServices::ImportService
  def perform
    spread_sheet = open_sheet

    spread_sheet.each do |row|
      if row.include? "Project"
        name = row.last
        @project = Project.find_by name: name
        if @project
          @logfile.write_success_log "Project was found with name #{name}"
        else
          @project = Project.new name: name
          @logfile.write_success_log "Project was created with name #{name}"
        end
        @found = true
      elsif row.include? "Requirement"
        @project.project_requirements.new name: row.last
        @logfile.write_success_log "Requirement '#{row.last}' was added to project #{@project.name} "
      end

    end

    if @found
      @project.save
    end
  end

  private
  def open_sheet
    Roo::Spreadsheet.open @file_path
  end
end
