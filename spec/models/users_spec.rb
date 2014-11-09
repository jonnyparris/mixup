require 'rails_helper'

RSpec.describe Users, :type => :model do
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
  xit { should have_many(:stems) }
  xit { should have_many(:remixes).with_foreign_key('remixer_id') }
  xit { should have_many(:circles) }
  xit { should have_many(:circles).through(:remixes) }
  end
end
