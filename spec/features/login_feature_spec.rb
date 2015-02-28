feature "Login" do
  scenario "should be successful with a welcome flash" do
    dilla = create(:user)
    visit login_path
    fill_in "email", with: dilla.email
    fill_in "password", with: "poppop"
    click_button("Login")
    expect(page).to have_content("Welcome")
  end

  scenario "should create a remember token if ticked" do
    dilla = create(:user)
    visit login_path
    fill_in "email", with: dilla.email
    fill_in "password", with: "poppop"
    check "Remember me"
    click_button("Login")
    expect(page).to have_link("Home")

    expire_cookies

    visit user_dashboard_path(dilla)
    expect(page).to have_content("Home")
  end
end
