FactoryGirl.define do
  factory :track do
    creator
    track_name Faker::Commerce.product_name
    download_url Faker::Internet.url
  end
end
