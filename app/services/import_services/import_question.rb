class ImportServices::ImportQuestion < ImportServices::ImportService
  REQUIRED_ATTRIBUTES = ["category", "question", "level", "is_correct"]

  def valid?
    super && data_type_valid?
  end

  def perform
    spread_sheet = open_sheet
    header = spread_sheet.row(1)
    (2..spread_sheet.last_row).each do |index|

      row = Hash[[header, spread_sheet.row(index)].transpose]

      category = Category.find_by name: row["category"].strip
      if category
        question_content = row["question"].to_s.strip

        question = category.questions.new content: question_content,
          level: row["level"].to_s.strip

        row.except(*REQUIRED_ATTRIBUTES).each do |key, answer|
          if answer
            question.answers.build content: answer.to_s.strip,
              is_correct: (key == row["is_correct"])
          end
        end

        if question.valid?
          @logfile.write_success_log "Question: #{question_content}"
          question.save
        else
          @logfile.write_fails_log "Question: #{question_content}"
        end
      end
    end
  end

  private
  def data_type_valid?
    attributes = REQUIRED_ATTRIBUTES.to_set
    spread_sheet = open_sheet
    header_set = spread_sheet.row(1).to_set
    attributes.subset? header_set
  end

  def open_sheet
    Roo::Spreadsheet.open @file_path
  end
end
