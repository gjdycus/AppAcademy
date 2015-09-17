class AddUsernameToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :email, :string
    add_column :users, :username, :string
    change_column_null :users, :username, false
    add_index :users, :username, unique: true
  end
end
