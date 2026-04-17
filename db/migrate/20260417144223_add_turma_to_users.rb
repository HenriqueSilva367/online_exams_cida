class AddTurmaToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :turma, null: true, foreign_key: true
  end
end
