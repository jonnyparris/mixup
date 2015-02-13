class ChangeAllocationFormatInCircles < ActiveRecord::Migration
  def up
    change_column :circles, :allocation, :text
  end

  def down
    change_column :circles, :allocation, :string
  end
end
