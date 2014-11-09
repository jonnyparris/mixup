class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string      :name
      t.datetime    :signup_deadline
      t.datetime    :submit_deadline
      t.timestamps
    end
  end
end
