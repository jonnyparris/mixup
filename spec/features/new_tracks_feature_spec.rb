feature "Add new tracks" do
  before :each do
    @j_dilla = create(:user)
    page.set_rack_session(user_id: @j_dilla.id)
  end

  scenario "should succeed for stems where user is specified" do
    visit new_user_stem_path(@j_dilla.id)
    fill_in "Download url", with: "https://soundcloud.com/alt-j/sets/breezeblock-remix-stems"
    fill_in "Track name", with: "BreezeBlock 2012 (original mix)"
    click_button("Submit")
    expect(page).to have_content("Sweet!")
  end

  scenario "should be editable after creation" do
    new_track = create(:track, creator: @j_dilla)
    visit user_stems_path(user_id: @j_dilla.id)
    click_link("#{new_track.track_name}")
    fill_in "Track name", with: "BoopyDoopy"
    click_button("Update")
    expect(page).to have_content("BoopyDoopy")
  end
end
