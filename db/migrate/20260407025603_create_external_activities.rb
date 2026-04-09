class CreateExternalActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :external_activities do |t|
      t.string :title
      t.text :description
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
