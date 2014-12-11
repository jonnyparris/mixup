feature "Add new tracks" do
  scenario "should succeed for stems where user is specified" do
    User.delete_all
    j_dilla = User.create(first_name: Faker::Name.first_name,
                          last_name: Faker::Name.last_name,
                          user_name: Faker::Internet.user_name,
                          email: Faker::Internet.email,
                          avatar: Faker::Avatar.image,
                          location: Faker::Address.city,
                          password_digest: "pop"
                          )
    visit new_user_stem_path(j_dilla.id)
    fill_in "Download url", with: "https://soundcloud.com/alt-j/sets/breezeblock-remix-stems"
    fill_in "Track name", with: "BreezeBlock 2012 (original mix"
    click_button("Submit")
    expect(page).to have_content("Sweet!")
  end
end
