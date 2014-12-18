describe "Circles" do
  before :each do
    User.delete_all
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

  it "circles returns a list of all circles" do
    Circle.delete_all
    Circle.create(name: "Xmas remixes",
           signup_deadline: Faker::Time.forward(23, :midnight),
           submit_deadline: Faker::Time.forward(300, :midnight),
           creator_id: @j_dilla.id
    )
    visit circles_path
    expect(page).to have_content("Xmas remixes")
  end
end

feature "Create Circle" do
  before :each do
    User.delete_all
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

  scenario "should flag an error if it fails" do
    visit new_circle_path
    click_button("Create Circle")
    expect(page).to have_content("Sorry")
  end

  scenario "should create new Circle with minimal fields filled in" do
    Circle.delete_all
    visit new_circle_path
    fill_in "Name", with: "xmas"
    fill_in "Signup deadline", with: Faker::Time.forward(23, :midnight)
    fill_in "Submit deadline", with: Faker::Time.forward(300, :midnight)
    click_button("Create Circle")
    expect(page).to have_content("Sweet!")
  end
end
