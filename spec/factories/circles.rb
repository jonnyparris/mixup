FactoryGirl.define do
  factory :circle do
    creator
    name Faker::Company.name
    signup_deadline Faker::Time.forward(23, :midnight)
    submit_deadline Faker::Time.forward(300, :midnight)
  end
end
