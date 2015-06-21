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
    fill_in "user_password", with: "j_dilla"
    # fill_in "user_password_confirmation", with: "j_dilla"
    click_button("Create User")
    expect(page).to have_content("Welcome")
  end

  # TODO lookup how capybara can check input field values
  xscenario "should not wipe all fields when there are any errors" do
    User.delete_all
    visit new_user_path
    fill_in "User name", with: "j_dilla"
    click_button("Create User")
    expect(page).to have_content("j_dilla")
    expect(page).to have_content("Sorry")
  end
end
