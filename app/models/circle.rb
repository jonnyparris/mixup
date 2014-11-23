class Circle < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :submissions

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :creator_id
  validates :signup_deadline, date: { before: :submit_deadline }
end
