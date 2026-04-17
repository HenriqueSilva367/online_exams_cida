class AddSimuladosReleasedToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :simulados_released, :boolean, default: false
  end
end
