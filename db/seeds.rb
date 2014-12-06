20.times do
       User.create(first_name: Faker::Name.first_name,
                     last_name: Faker::Name.last_name,
                     user_name: Faker::Internet.user_name,
                     email: Faker::Internet.email,
                     avatar: Faker::Avatar.image,
                     location: Faker::Address.city,
                     password_digest: "pop"
                     )
end

10.times do
       Circle.create(name: Faker::Commerce.color,
              signup_deadline: Faker::Time.forward(23, :midnight),
              submit_deadline: Faker::Time.forward(48, :midnight),
              creator_id: rand(User.count+1))
end
