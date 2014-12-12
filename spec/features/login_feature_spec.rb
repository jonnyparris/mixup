feature "Login" do
  scenario "should be successful with a welcome flash" do
    User.delete_all
    User.create(user_name: "j_dilla", email: "a", password: "madbeatz")
    visit login_path
    fill_in "email", with: "a"
    fill_in "password", with: "madbeatz"
    click_button("Login")
    expect(page).to have_content("Welcome")
  end
end
