class CreateSimulationReleases < ActiveRecord::Migration[8.0]
  def change
    create_table :simulation_releases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end

    add_index :simulation_releases, [:user_id, :exam_id], unique: true
  end
end
