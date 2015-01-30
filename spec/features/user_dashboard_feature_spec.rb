describe "User Dashboard" do
  before :each do
    @j_dilla = create(:user)
    page.set_rack_session(user_id: @j_dilla.id)
  end

  it "includes list of all circles by default, but declares if there are no circles" do
    visit user_dashboard_path(@j_dilla.id)
    expect(page).to have_content("No Circles")
  end

  it "includes a link to previous circles only when there are previous circles to return to" do
    40.times do
      create(:future_circle, creator: @j_dilla)
    end
    visit user_dashboard_path(@j_dilla.id)
    expect(page).to_not have_content("Prev")
    click_link "More Circles"
    expect(page).to have_content("Prev")
    expect(page).to have_content("More Circles")
  end
end
