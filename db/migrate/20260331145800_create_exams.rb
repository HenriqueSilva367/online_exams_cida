class CreateExams < ActiveRecord::Migration[8.0]
  def change
    create_table :exams do |t|
      t.references :topic, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :difficulty
      t.integer :time_duration

      t.timestamps
    end
  end
end
