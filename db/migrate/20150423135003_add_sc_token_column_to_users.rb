class AddScTokenColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sc_token, :string
  end
end
