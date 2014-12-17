describe "User Dashboard" do
  before :each do
    User.delete_all
    Circle.delete_all
    @j_dilla = User.create(first_name: Faker::Name.first_name,
                           last_name: Faker::Name.last_name,
                           user_name: Faker::Internet.user_name,
                           email: "a",
                           avatar: Faker::Avatar.image,
                           location: Faker::Address.city,
                           password: "poppop"
                           )
    visit login_path
    fill_in "email", with: "a"
    fill_in "password", with: "poppop"
    click_button("Login")
  end

  it "includes list of all circles by default, but declares if there are no circles" do
    visit user_dashboard_path(@j_dilla.id)
    expect(page).to have_content("No Circles")
  end

  it "includes a link to previous circles only when there are previous circles to return to" do
    40.times do
           Circle.create(name: Faker::Commerce.color,
                  signup_deadline: Faker::Time.forward(2, :midnight),
                  submit_deadline: Faker::Time.forward(80, :midnight),
                  creator_id: @j_dilla.id)
    end
    visit user_dashboard_path(@j_dilla.id)
    expect(page).to_not have_content("Prev")
    click_link "More Circles"
    expect(page).to have_content("Prev")
    expect(page).to have_content("More Circles")
  end
end
