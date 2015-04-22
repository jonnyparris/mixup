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

  def created_by_message(current_user)
    if self.has_admin(current_user)
      if self.creator == current_user
        "created by: YOU"
      else
        "created by: #{self.creator.user_name}, but you're an admin too!"
      end
    else
      "created by: #{self.creator.user_name}"
    end
  end

  def deadline_message(current_user)
    if self.status == "finished"
      "FINISHED"
    elsif self.status == "in progress"
      self.submission_message(current_user)
    else
      self.signup_message(current_user)
    end
  end

  def submission_message(current_user)
    if self.needs_remix_from(current_user)
      if self.days_to_submit == 1
        "1 more day before submission deadline"
      elsif self.days_to_submit > 1
        "#{self.days_to_submit} days to submit your remix"
      else
        "#{countdown_24hrs(self.submit_deadline)} to submit your remix!"
      end
    else
      if self.days_to_submit == 1
        "1 more day before remixes unveiled"
      elsif self.days_to_submit > 1
        "#{self.days_to_submit} days before remixes unveiled"
      else
        "#{countdown_24hrs(self.submit_deadline)} left before remixes unveiled!"
      end
    end
  end

  def signup_message(current_user)
    if self.has_member(current_user)
      if self.days_to_signup == 1
        "1 more day before mixup begins"
      elsif self.days_to_signup > 1
        "#{self.days_to_signup} days before mixup"
      else
        "#{countdown_24hrs(self.signup_deadline)} before mixup begins!"
      end
    else
      if self.days_to_signup == 1
        "1 more day to join circle"
      elsif self.days_to_signup > 1
        "#{self.days_to_signup} days to join circle"
      else
        "#{countdown_24hrs(self.signup_deadline)} left to join circle!"
      end
    end
  end

  def days_to_signup
    ((self.signup_deadline - DateTime.now)/86400).floor
  end

  def days_to_submit
    ((self.submit_deadline - DateTime.now)/86400).floor
  end

  def countdown_24hrs(deadline)
    now = Time.now
    secs_left = (deadline - now).to_i
    hours_left = secs_left/3600.floor
    mins_left = secs_left/60.floor
    if hours_left > 0
      "#{hours_left}hrs"
    elsif mins_left > 0
      "#{mins_left} minutes"
    else
      "#{secs_left} seconds"
    end
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

  def stem_from(user)
    return false unless self.has_member(user)
    Submission.where(circle_id: self.id).detect { |submission| submission.original.creator == user}
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
end
