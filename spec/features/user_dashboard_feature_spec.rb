describe "User Dashboard" do
  it "includes list of all circles by default" do
    visit 'users/1/dashboard'
    expect(page).to have_content("All Circles")
  end
end
