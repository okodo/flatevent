FactoryGirl.define do

  factory :event do
    sequence(:title) { |n| "Event #{n}" }
    sequence(:starts_at) { |n| Time.now + n.days }
    recurs_on { %i(n_a day week month year).sample }

    after(:build) do |event, e|
      event.user_id = create(:user).id if event.user_id.blank?
    end
  end

end
