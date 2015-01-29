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
    it { should have_many(:stems).class_name('Track').with_foreign_key('creator_id') }
    it { should have_many(:remixes).class_name('Track').with_foreign_key('creator_id') }
    it { should have_many(:circles).with_foreign_key('creator_id') }
  end

  describe "validations" do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should ensure_length_of(:user_name).is_at_most(64) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should have_secure_password }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:user_name).case_insensitive }
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
end
