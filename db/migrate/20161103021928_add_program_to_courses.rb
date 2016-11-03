class AddProgramToCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses, :program, foreign_key: true
  end
end
