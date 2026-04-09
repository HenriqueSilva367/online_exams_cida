class CreateExerciseAuthorizations < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.boolean :authorized

      t.timestamps
    end
  end
end
