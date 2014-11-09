class CreateStems < ActiveRecord::Migration
  def change
    create_table :stems do |t|
      t.string      :track_name
      t.string      :download_url
      t.timestamps
    end
  end
end
