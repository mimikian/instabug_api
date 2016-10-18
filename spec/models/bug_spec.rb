require 'rails_helper'

RSpec.describe Bug, type: :model do
  before { @bug = FactoryGirl.build(:bug) }

  subject { @bug }

  it { should respond_to(:application_token) }
  it { should respond_to(:number) }
  it { should respond_to(:status) }
  it { should respond_to(:priority) }
  it { should respond_to(:comment) }

  it { should be_valid }
end
