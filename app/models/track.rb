class Track < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :stem_submissions, class_name: "Submission", foreign_key: "original_id"
  has_many :remix_submissions, class_name: "Submission", foreign_key: "remix_id"
end
