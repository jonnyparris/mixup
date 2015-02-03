class Submission < ActiveRecord::Base
  belongs_to :circle
  belongs_to :original, class_name: "Track"
  belongs_to :remix, class_name: "Track"

  validates_presence_of :original_id
  validates_presence_of :circle_id
  validates_uniqueness_of :original_id, case_sensitive: false, scope: :circle_id
  validates_uniqueness_of :remix_id, case_sensitive: false, scope: :circle_id, allow_nil: true, allow_blank: true

  def destroy_remix
    self.remix_id = nil
    self.save
  end
end
