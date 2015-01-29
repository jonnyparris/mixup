describe "Circles" do
  before :each do
    Circle.delete_all
    User.delete_all
    @j_dilla = create(:user)
    visit login_path
    fill_in "email", with: @j_dilla.email
    fill_in "password", with: "poppop"
    click_button("Login")
  end

  it "index list exists" do
    new_circle = create(:future_circle,creator: @j_dilla)
    visit circles_path
    expect(page).to have_content(new_circle.name)
  end

  scenario "should flag an error if creation fails" do
    visit new_circle_path
    click_button("Create Circle")
    expect(page).to have_content("Sorry")
  end

  scenario "should create new Circle with minimal fields filled in" do
    visit new_circle_path
    nearly_new_circle = build(:future_circle)
    fill_in "Name", with: nearly_new_circle.name
    fill_in "Signup deadline", with: nearly_new_circle.signup_deadline
    fill_in "Submit deadline", with: nearly_new_circle.submit_deadline
    click_button("Create Circle")
    expect(page).to have_content("Sweet!")
  end
end
