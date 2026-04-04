class AddAnacFieldsToModels < ActiveRecord::Migration[8.0]
  def change
    add_reference :questions, :topic, null: true, foreign_key: true
    add_column :exams, :exam_type, :integer, default: 0
    add_column :exam_sessions, :result_status, :integer, default: 0
    add_column :exam_sessions, :detailed_results, :jsonb
  end
end
