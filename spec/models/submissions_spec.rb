require 'rails_helper'

RSpec.describe Submission, :type => :model do
  describe "attributes" do
    it { should respond_to(:original_id) }
    it { should respond_to(:remix_id) }
    it { should respond_to(:circle_id) }
  end

  describe "associations" do
    it { should belong_to(:circle) }
    it { should belong_to(:original).class_name("Track") }
    it { should belong_to(:remix).class_name("Track") }
  end

  describe "validations" do
    it { should validate_presence_of(:original_id) }
    it { should validate_presence_of(:circle_id) }
  end
end
