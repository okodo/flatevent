require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }

  it "bad date format for starts_at" do
    should_not allow_value("").for(:starts_at)
    should_not allow_value("30-02-2015").for(:starts_at)
  end

end
