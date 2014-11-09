class RenameStemsTable < ActiveRecord::Migration
  def change
    rename_table :stems, :tracks
  end
end
