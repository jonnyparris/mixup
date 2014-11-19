class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :circle
      t.references :original
      t.references :remix

      t.timestamps
   end
  end
end
