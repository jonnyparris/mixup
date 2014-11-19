class Submission < ActiveRecord::Base
  belongs_to :circle
  belongs_to :original, class_name: "Track"
  belongs_to :remix, class_name: "Track"
end
