feature "Mixup Circle" do

  before do
    @j_dilla = create(:user)
    page.set_rack_session(user_id: @j_dilla.id)
    @new_beat = create(:track, creator: @j_dilla)
  end

  scenario "should only be an option for circles created by current user" do
    first_circle = create(:future_circle)
    visit circle_path(first_circle)
    expect(page).to_not have_content("Start mixup")
    owned_circle = create(:future_circle, creator: @j_dilla)
    visit circle_path(owned_circle)
    expect(page).to have_content("Start mixup")
  end

  scenario "should declare which stem was allocated to current user for remix" do
    present_circle = create(:present_circle)
    create_list(:stem_submit, 5, circle: present_circle)
    create(:submission, circle: present_circle, original: @new_beat)
    visit circle_path(present_circle)
    expect(page).to_not have_content("Waiting for")
    present_circle.mixup
    visit circle_path(present_circle)
    expect(page).to have_content("Waiting for")
  end

  xscenario "should trigger when signup deadline passes" do

  end

  xscenario "should fail if less than 3 members" do

  end

  xscenario "should never assign a stem back to its owner to remix" do

  end
end
