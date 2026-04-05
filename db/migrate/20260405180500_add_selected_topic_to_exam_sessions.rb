class AddSelectedTopicToExamSessions < ActiveRecord::Migration[8.0]
  def change
    add_reference :exam_sessions, :selected_topic, foreign_key: { to_table: :topics }, null: true
  end
end
