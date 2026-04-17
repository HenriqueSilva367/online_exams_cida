class CreateTurmaSimulationReleases < ActiveRecord::Migration[8.0]
  def change
    create_table :turma_simulation_releases do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end

    add_index :turma_simulation_releases, [:turma_id, :exam_id], unique: true
  end
end
