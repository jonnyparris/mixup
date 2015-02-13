class AddAllocationToCircles < ActiveRecord::Migration
  def change
    add_column :circles, :allocation, :string
  end
end
