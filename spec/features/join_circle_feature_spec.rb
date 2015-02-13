feature "View, then join Circle" do
  before :each do
    @j_dilla = create(:user)
    page.set_rack_session(user_id: @j_dilla.id)
    @new_beat = create(:track, creator: @j_dilla)
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
    @submission_attempt = Submission.create(original_id: @newer_beat.id,
                      circle_id: @xmas.id)
    visit circle_path(@xmas)
    expect(page).to have_content(@rick_rubin.user_name)
  end
end
