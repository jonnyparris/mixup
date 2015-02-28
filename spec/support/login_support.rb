require 'spec_helper'

module LoginSupport
  def login_as(user, options = {})
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button("Login")
  end
end
