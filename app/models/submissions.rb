class Submissions < ActiveRecord::Base
  belongs_to :original, class_name: "Track"
  belongs_to :remix, class_name: "Track"
  belongs_to :circle
end
