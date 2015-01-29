feature "View, then join Circle" do
  before :each do
    User.delete_all
    @j_dilla = create(:user)
    visit login_path
    fill_in "email", with: @j_dilla.email
    fill_in "password", with: "poppop"
    click_button("Login")
    Track.delete_all
    @new_beat = create(:track, creator: @j_dilla)
    Circle.delete_all
    @xmas = create(:future_circle, creator: @j_dilla)
  end

  scenario "should be successful if within signup deadline" do
    visit circle_path(@xmas)
    expect(page).to have_content("Join")
    click_button @new_beat.track_name
    expect(page).to_not have_content("Join")
    expect(page).to have_content("UNDO")
  end

  scenario "should have a list of circle members" do
    @rick_rubin = create(:user)
    @newer_beat = create(:track, creator: @rick_rubin)
    visit circle_path(@xmas)
    expect(page).to_not have_content(@rick_rubin.user_name)
    Submission.delete_all
    @submission_attempt = Submission.create(original_id: @newer_beat.id,
                      circle_id: @xmas.id)
    visit circle_path(@xmas)
    expect(page).to have_content(@rick_rubin.user_name)
  end
end
