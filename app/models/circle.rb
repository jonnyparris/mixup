class Circle < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :submissions

  validates_presence_of :name
  validates_presence_of :signup_deadline
  validates_presence_of :submit_deadline
  validates_uniqueness_of :name, scope: :creator_id
  validates :signup_deadline, date: { before: :submit_deadline }

  def members
    Submission.where(circle_id: self.id)
                 .map { |submission| submission.original.creator }
  end

  def has_member(user)
    self.members.include? user
  end

  def has_admin(user)
    self.creator == user
  end

  def mixup
    stems = self.submissions.map { |submission| submission.original.id }
    remixers = self.members.map { |member| member.id }
    first_random_rotation_integer = (1..stems.length-1).to_a.sample
    second_random_rotation_integer = (1..stems.length-1).to_a.sample

    stems.rotate!(first_random_rotation_integer)
    remixers.rotate!(first_random_rotation_integer)
    remixers.rotate!(second_random_rotation_integer)
    @allocations = Hash[remixers.zip(stems)]
    self.allocation = @allocations.to_json
    self.save!
  end

  def allocation_hash
    return false if self.allocation.nil?
    JSON.parse(self.allocation)
  end

  def needs_remix_from(user_id)
    self.allocation_hash.keys.include? "#{user_id}"
  end

  def allocated_stem(user_id)
    Track.find(self.allocation_hash["#{user_id}"])
  end
end
