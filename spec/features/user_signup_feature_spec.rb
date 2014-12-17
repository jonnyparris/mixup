feature "User Signup" do
  scenario "should flag an error if it fails" do
    visit new_user_path
    click_button("Create User")
    expect(page).to have_content("Sorry")
  end

  scenario "should create new user with minimal fields filled in" do
    User.delete_all
    visit new_user_path
    fill_in "User name", with: "j_dilla"
    fill_in "Email", with: "j_dilla"
    fill_in "Password", with: "j_dilla"
    fill_in "Password confirmation", with: "j_dilla"
    click_button("Create User")
    expect(page).to have_content("Welcome")
  end
end
