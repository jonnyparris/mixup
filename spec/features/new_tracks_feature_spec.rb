feature "Add new tracks" do
  before :all do
    User.delete_all
    @j_dilla = User.create(first_name: Faker::Name.first_name,
                          last_name: Faker::Name.last_name,
                          user_name: Faker::Internet.user_name,
                          email: Faker::Internet.email,
                          avatar: Faker::Avatar.image,
                          location: Faker::Address.city,
                          password_digest: "pop"
                          )
    Track.delete_all
  end

  scenario "should succeed for stems where user is specified" do
    visit new_user_stem_path(@j_dilla.id)
    fill_in "Download url", with: "https://soundcloud.com/alt-j/sets/breezeblock-remix-stems"
    fill_in "Track name", with: "BreezeBlock 2012 (original mix)"
    click_button("Submit")
    expect(page).to have_content("Sweet!")
  end

  scenario "should be editable after creation" do
    Track.create(download_url: "something", track_name: "BreezeBlock", creator_id: @j_dilla.id)
    visit user_stems_path(user_id: @j_dilla.id)
    click_link("BreezeBlock")
    fill_in "Track name", with: "BoopyDoopy"
    click_button("Update")
    expect(page).to have_content("BoopyDoopy")
  end
end
