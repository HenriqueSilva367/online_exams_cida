class CreateExamSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :exam_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.integer :status, default: 0
      t.integer :score
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
