require 'rails_helper'

RSpec.describe Circle, :type => :model do
  describe "attributes" do
    it { should respond_to(:name) }
    it { should respond_to(:signup_deadline) }
    it { should respond_to(:submit_deadline) }

    it { should respond_to(:creator_id) }
  end

  describe "associations" do
    it { should belong_to(:creator).class_name("User") }
    it { should have_many(:submissions) }
  end
end
