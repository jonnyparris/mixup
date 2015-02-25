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

  def allocated_stem(circle_id)
    Circle.find(circle_id).allocated_stem(self.id)
  end
end
