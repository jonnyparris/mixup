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
    it { should validate_uniqueness_of(:original_id).case_insensitive.scoped_to(:circle_id) }
    it { should validate_uniqueness_of(:remix_id).case_insensitive.scoped_to(:circle_id) }
  end

  it "has a valid factory" do
    expect(build(:submission)).to be_valid
    expect(build(:stem_submit)).to be_valid
  end
end
