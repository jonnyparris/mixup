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
end
