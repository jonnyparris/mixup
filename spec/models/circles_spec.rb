require 'rails_helper'

RSpec.describe Circles, :type => :model do
  describe "attributes" do
    it { should respond_to(:name) }
    it { should respond_to(:signup_deadline) }
    it { should respond_to(:submit_deadline) }

    xit { should respond_to(:creator_id) }
  end

  xdescribe "associations" do
    it { should belong_to(:producer).with_foreign_key('creator_id') }
    it { should have_many(:remix) }
  end
end
