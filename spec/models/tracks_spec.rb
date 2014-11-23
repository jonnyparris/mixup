require 'rails_helper'

RSpec.describe Track, :type => :model do
  describe "attributes" do
    it { should respond_to(:track_name) }
    it { should respond_to(:download_url) }
    it { should respond_to(:creator_id) }
  end

  describe "associations" do
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:stem_submissions).class_name('Submission').with_foreign_key('original_id') }
    it { should have_many(:remix_submissions).class_name('Submission').with_foreign_key('remix_id') }
  end

  describe "validations" do
    it { should validate_presence_of(:track_name) }
    it { should validate_presence_of(:download_url) }
    it { should validate_presence_of(:creator_id) }
    it { should validate_uniqueness_of(:track_name).case_insensitive.scoped_to(:creator_id) }
  end
end
