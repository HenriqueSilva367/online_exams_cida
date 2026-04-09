class RenameNameInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :name, :full_name
  end
end
