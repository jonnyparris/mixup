feature "Submit Remix" do
  before do
    @j_dilla = create(:user)
    login_as(@j_dilla)
    @new_beat = create(:track, creator: @j_dilla, track_name: "HippityHop")
    @present_circle = create(:present_circle)
    create_list(:stem_submit, 5, circle: @present_circle)
    create(:submission, circle: @present_circle, original: @new_beat)
    @present_circle.mixup
    visit circle_path(@present_circle)
  end

  scenario "should succeed from existing tracks uploaded" do
    remix = create(:track, creator: @j_dilla, track_name: "Baroque Remix")
    click_link "Submit your remix!"
    click_button "#{remix.track_name}"
    expect(page).to have_content("#{@present_circle.name}")
    expect(page).to have_content("Success!")
    expect(page).to have_content("UNDO")
    expect(page).to_not have_content("Waiting for")
  end

end
