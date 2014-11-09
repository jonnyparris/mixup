require 'rails_helper'

RSpec.describe Stems, :type => :model do
  describe "attributes" do
    it { should respond_to(:track_name) }
    it { should respond_to(:download_url) }
    xit { should respond_to(:producer) }
  end

  describe "associations" do
    xit { should belong_to(:producer) }
    xit { should have_many(:remixes) }
    xit { should have_many(:circles).through(:remixes) }
  end
end
