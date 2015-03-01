class Track < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :stem_submissions, class_name: "Submission", foreign_key: "original_id"
  has_many :remix_submissions, class_name: "Submission", foreign_key: "remix_id"

  validates_presence_of :track_name
  validates_presence_of :download_url
  validates_presence_of :creator_id
  validates_uniqueness_of :track_name, case_sensitive: false, scope: :creator_id

  before_save :sanitize_url

  def sanitize_url
    return if self.download_url.nil?
    unless self.download_url.include?("http://") || self.download_url.include?("https://")
      self.download_url = "http://" + self.download_url
    end
  end

end
