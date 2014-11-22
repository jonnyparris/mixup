class Track < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :submissions, foreign_key: "original_id"
end
