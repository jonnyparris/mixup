class User < ActiveRecord::Base
  has_secure_password

  has_many :stems, class_name: "Track", foreign_key: "creator_id"
  has_many :remixes, class_name: "Track", foreign_key: "creator_id"
  has_many :circles, foreign_key: "creator_id"

  validates_presence_of :user_name
  validates_presence_of :email

  validates_length_of :password, minimum: 6, allow_blank: true
  validates_length_of :user_name, maximum: 64

  validates_uniqueness_of :user_name, case_sensitive: false
  validates_uniqueness_of :email, case_sensitive: false

  before_create { generate_token(:auth_token) }
  before_save :set_avatar

  mount_uploader :avatar, AvatarUploader
  DEFAULT_AVATAR = "http://www.avatarsdb.com/avatars/mr_pouty.jpg"

  def set_avatar
    self.avatar.url = DEFAULT_AVATAR if self.avatar.nil?
  end

  def allocated_stem(circle_id)
    Circle.find(circle_id).allocated_stem(self.id)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    UserMailer.password_reset(self).deliver
    self.password_sent_at = Time.now
    save!
  end
end
