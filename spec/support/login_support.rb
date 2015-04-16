require 'spec_helper'

module LoginSupport
  def login_as(user, options = {})
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("Login")
  end
end
