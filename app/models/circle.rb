class Circle < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :submissions

  validates_presence_of :name
  validates_presence_of :signup_deadline
  validates_presence_of :submit_deadline
  validates_uniqueness_of :name, scope: :creator_id
  validates :signup_deadline, date: { before: :submit_deadline }

  def has_member(user)
    circle_members = Submission.where(circle_id: self.id)
                                  .map { |submission| submission.original.creator }
    circle_members.include? user
  end
end
