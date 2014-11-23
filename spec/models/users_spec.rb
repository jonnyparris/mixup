require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "attribute" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:user_name) }
    it { should respond_to(:email) }
    it { should respond_to(:avatar) }
    it { should respond_to(:location) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password_confirmation) }
  end

  describe "associations" do
    it { should have_many(:tracks) }
    it { should have_many(:circles) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:user_name).is_at_most(64) }
    it { should have_secure_password }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:user_name).case_insensitive }
  end
end
