FactoryGirl.define do
  factory :track, aliases: [:original, :remix] do
    creator
    sequence(:track_name) { |n| "#{Faker::Commerce.product_name}#{n}" }
    download_url Faker::Internet.url
  end
end
