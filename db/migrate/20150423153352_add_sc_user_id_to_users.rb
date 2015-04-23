class AddScUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sc_user_id, :integer
  end
end
