class Circle < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :submissions

  validates_presence_of :name
  validates_presence_of :signup_deadline
  validates_presence_of :submit_deadline
  validates_uniqueness_of :name, scope: :creator_id
  validates :signup_deadline, date: { before: :submit_deadline, message: "must be before submission deadline" }

  def div_class(current_user)
    self.has_admin(current_user) ? "circle-thumb my-circle" : "circle-thumb"
  end

  def members_count
    self.members.count == 1 ? "1 member" : "#{self.members.count} members"
  end

  def days_to_signup
    ((self.signup_deadline - DateTime.now)/86400).floor
  end

  def days_to_submit
    ((self.submit_deadline - DateTime.now)/86400).floor
  end

  def status
    if self.days_to_signup < 0 && self.days_to_submit < 0
      "finished"
    elsif self.days_to_signup < 0
      "in progress"
    else
      "not started"
    end
  end

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
    return false if self.members.count < 3
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
    JSON.parse(self.allocation)
  end

  def needs_remix_from(user_id)
    return false if self.allocation.nil?
    return false unless Submission.find_by(circle_id: self.id, original_id: self.allocated_stem(user_id).id).remix_id.nil?
    self.allocation_hash.keys.include? "#{user_id}"
  end

  def allocated_stem(user_id)
    return false if self.allocation.nil?
    Track.find(self.allocation_hash["#{user_id}"])
  end
end
