FactoryGirl.define do
  factory :circle do
    creator
    sequence(:name) { |n| "#{Faker::Company.name}#{n}" }

    trait :future do
      signup_deadline Faker::Time.forward(23, :midnight)
      submit_deadline Faker::Time.forward(300, :midnight)
    end

    trait :present do
      signup_deadline Faker::Time.backward(23, :midnight)
      submit_deadline Faker::Time.forward(300, :midnight)
    end

    trait :past do
      signup_deadline Faker::Time.backward(300, :midnight)
      submit_deadline Faker::Time.backward(23, :midnight)
    end

    factory :future_circle,   traits: [:future]
    factory :present_circle,   traits: [:present]
    factory :past_circle,   traits: [:past]
  end
end
