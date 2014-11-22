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
    xit { should have_many(:circles).through(:remixes) }
  end
end
