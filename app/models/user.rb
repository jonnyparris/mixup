class User < ActiveRecord::Base
  has_secure_password

  has_many :tracks, foreign_key: "creator_id"
  has_many :circles, foreign_key: "creator_id"
end
