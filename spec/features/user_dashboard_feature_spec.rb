describe "User Dashboard" do
  before :each do
    @j_dilla = create(:user)
    login_as(@j_dilla)
  end

  it "includes list of all circles by default, but declares if there are no circles" do
    visit user_dashboard_path(@j_dilla.id)
    expect(page).to have_content("No Circles")
  end

  it "includes a link to previous circles only when there are previous circles to return to" do
    create_list(:future_circle, 40, creator: @j_dilla)
    visit user_dashboard_path(@j_dilla.id)
    expect(page).to_not have_content("Prev")
    click_link "More Circles"
    expect(page).to have_content("Prev")
    expect(page).to have_content("More Circles")
  end
end
