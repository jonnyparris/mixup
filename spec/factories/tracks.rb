FactoryGirl.define do
  factory :track, aliases: [:original, :remix] do
    creator
    track_name Faker::Commerce.product_name
    download_url Faker::Internet.url
  end
end
