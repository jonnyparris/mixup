feature "View, then join Circle" do
  before :each do
    User.delete_all
    @j_dilla = User.create(first_name: Faker::Name.first_name,
                           last_name: Faker::Name.last_name,
                           user_name: Faker::Internet.user_name,
                           email: "a",
                           avatar: Faker::Avatar.image,
                           location: Faker::Address.city,
                           password: "poppop"
                           )
    visit login_path
    fill_in "email", with: "a"
    fill_in "password", with: "poppop"
    click_button("Login")
    Track.delete_all
    @new_beat = Track.create(download_url: "something",
                             track_name: "BreezeBlock",
                             creator_id: @j_dilla.id)
    Circle.delete_all
    @xmas = Circle.create(name: "Xmas remixes",
                          signup_deadline: Faker::Time.forward(23, :midnight),
                          submit_deadline: Faker::Time.forward(300, :midnight),
                          creator_id: @j_dilla.id)
  end

  scenario "should be successful if within signup deadline" do
    visit circle_path(@xmas)
    expect(page).to have_content("Join")
    click_button @new_beat.track_name
    expect(page).to_not have_content("Join")
    expect(page).to have_content("UNDO")
  end

  scenario "should have a list of circle members" do
    @rick_rubin = User.create(first_name: Faker::Name.first_name,
                              last_name: Faker::Name.last_name,
                              user_name: Faker::Internet.user_name,
                              email: "b",
                              avatar: Faker::Avatar.image,
                              location: Faker::Address.city,
                              password: "poppop")
    @newer_beat = Track.create(download_url: "something",
                             track_name: "rock beat",
                             creator_id: @rick_rubin.id)
    visit circle_path(@xmas)
    expect(page).to_not have_content(@rick_rubin.user_name)
    Submission.delete_all
    @submission_attempt = Submission.create(original_id: @newer_beat.id,
                      circle_id: @xmas.id)
    visit circle_path(@xmas)
    expect(page).to have_content(@rick_rubin.user_name)
  end
end
