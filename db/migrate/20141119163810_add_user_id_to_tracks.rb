class AddUserIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks,   :creator_id, :integer
    add_column :circles,  :creator_id, :integer
  end
end
