class RestoreMissingFieldsToExams < ActiveRecord::Migration[8.0]
  def change
    add_column :exams, :time_duration, :integer unless column_exists?(:exams, :time_duration)
    add_column :exams, :difficulty, :string unless column_exists?(:exams, :difficulty)
  end
end
