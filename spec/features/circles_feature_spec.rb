describe "Circles" do
  it "circles/index returns a list of all circles" do
    User.delete_all
    j_dilla = User.create(first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  user_name: Faker::Internet.user_name,
                  email: Faker::Internet.email,
                  avatar: Faker::Avatar.image,
                  location: Faker::Address.city,
                  password: "poppop"
                  )
    Circle.delete_all
    Circle.create(name: "Xmas remixes",
           signup_deadline: Faker::Time.forward(23, :midnight),
           submit_deadline: Faker::Time.forward(300, :midnight),
           creator_id: j_dilla.id
    )
    visit 'circles'
    expect(page).to have_content("Xmas remixes")
  end
end
