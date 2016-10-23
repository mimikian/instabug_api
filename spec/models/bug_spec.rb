require 'rails_helper'
require 'shoulda/matchers'
RSpec.describe Bug, type: :model do
  before { @bug = FactoryGirl.build(:bug) }

  subject { @bug }

  it { should respond_to(:application_token) }
  it { should respond_to(:number) }
  it { should respond_to(:status) }
  it { should respond_to(:priority) }
  it { should respond_to(:comment) }

  it { should be_valid }
  it { should validate_presence_of(:application_token) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:priority) }
  it { should allow_value('new').for(:status) }
  it { should allow_value('In-progress').for(:status) }
  it { should allow_value('closed').for(:status) }

end
