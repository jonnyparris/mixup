FactoryGirl.define do
  factory :user, aliases: [:creator] do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    user_name Faker::Internet.user_name
    sequence(:email) { |n| "bewbs#{n}@email.com"}
    avatar Faker::Avatar.image
    location Faker::Address.city
    password "poppop"
  end
end
