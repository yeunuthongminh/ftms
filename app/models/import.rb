class Import
  attr_accessor :file

  def initialize file
    @file = file
  end

  def valid?
    File.exists?(@file) && correct_file_type?
  end

  def save!
    if correct_file_type?
      save_from_sheet
    end
  end

  private
  def correct_file_type?
    extension = File.extname @file.original_filename
    extension_name = extension[1..extension.length-1]
    Settings.import.file_types.respond_to? extension_name.to_sym
  end

  def open_sheet
    case File.extname @file.original_filename
    when Settings.import.file_types.csv then Roo::CSV.new @file.path
    when Settings.import.file_types.xls then Roo::Excel.new @file.path
    when Settings.import.file_types.xlsx then Roo::Excelx.new @file.path
    end
  end

  def save_from_sheet
    spread_sheet = open_sheet
    question = Question.new
    (2..spread_sheet.last_row).each do |number|
      current_row = spread_sheet.row number
      content = current_row[1]
      if current_row.first == Question.name
        subject_id = current_row.last.to_i
        question = Question.create content: content, subject_id: subject_id
      else
        is_correct = current_row.last.to_i == 1 ? true : false
        Answer.create content: content, is_correct: is_correct, question_id: question.id
      end
    end
    true
  end
end
