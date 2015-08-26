FactoryGirl.define do
  factory :user do
    password "Pa55w0rd!"
    password_confirmation "Pa55w0rd!"
    sequence(:email) { |n| "kii#{n}@ocodo.ru" }
    sequence(:fullname) { |n| "Fullname #{n}" }
  end

end
