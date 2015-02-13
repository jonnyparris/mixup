feature "Login" do
  scenario "should be successful with a welcome flash" do
    dilla = create(:user)
    visit login_path
    fill_in "email", with: dilla.email
    fill_in "password", with: "poppop"
    click_button("Login")
    expect(page).to have_content("Welcome")
  end
end
