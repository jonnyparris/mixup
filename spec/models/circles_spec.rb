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

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:signup_deadline) }
    it { should validate_presence_of(:submit_deadline) }
    it { should validate_uniqueness_of(:name).scoped_to(:creator_id) }

    it "is invalid if signup_deadline is after submit_deadline" do
      invalid_circle = Circle.new(name: 'Xmas Giggles', signup_deadline: '1/12/2014', submit_deadline: '1/11/2014')
      expect(invalid_circle).to have(1).errors_on(:signup_deadline)
    end
  end
end
