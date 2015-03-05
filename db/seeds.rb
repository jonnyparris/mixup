20.times do
  producer = User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              user_name: Faker::Internet.user_name,
              email: Faker::Internet.email,
              remote_avatar_url: Faker::Avatar.image,
              location: Faker::Address.city,
              password: "poppop")
  3.times do
    Track.create(track_name: Faker::Company.name,
                 download_url: Faker::Company.logo,
                 creator_id: producer.id)
  end
end

10.times do
  group = Circle.create(name: Faker::Commerce.color,
                signup_deadline: Faker::Time.forward(23, :midnight),
                submit_deadline: Faker::Time.forward(48, :midnight),
                creator_id: Random.new.rand(1..User.count + 1))
end

30.times do
  Submission.create(original_id: Random.new.rand(1..Track.count + 1),
                    circle_id: Random.new.rand(1..Circle.count + 1))
end
