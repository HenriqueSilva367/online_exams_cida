class CreateSessionAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :session_answers do |t|
      t.references :exam_session, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
