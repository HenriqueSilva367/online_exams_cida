class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :canac, :string
    add_index :users, :canac, unique: true
    add_column :users, :cpf, :string
    add_index :users, :cpf, unique: true
    add_column :users, :phone, :string
    add_column :users, :student_type, :integer, default: 0
    add_index :users, :student_type
    add_column :users, :credits, :integer, default: 0
    add_index :users, :credits
    add_column :users, :must_change_password, :boolean, default: true
    add_index :users, :must_change_password
  end
end
