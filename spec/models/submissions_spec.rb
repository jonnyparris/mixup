require 'rails_helper'

RSpec.describe Submissions, :type => :model do
  it { should respond_to(:original_id) }
  it { should respond_to(:remix_id) }
  it { should respond_to(:circle_id) }
end
