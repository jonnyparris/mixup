describe "Circles" do
  it "circles/index returns a list of all circles" do
    Circle.delete_all
    Circle.create(name: "Xmas remixes",
           signup_deadline: Faker::Time.forward(23, :midnight),
           submit_deadline: Faker::Time.forward(48, :midnight),
    )
    visit 'circles/index'
    expect(page).to have_content("Xmas remixes")
  end
end
