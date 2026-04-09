class RemoveLegacyFieldsFromExams < ActiveRecord::Migration[8.0]
  def change
    remove_column :exams, :difficulty, :string
    remove_column :exams, :time_duration, :integer
  end
end
