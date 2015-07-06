require 'spec_helper'

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit "/users/sign_up"

    fill_in "First name",            :with => "John"
    fill_in "Last name",             :with => "Doe"
    fill_in "Email",                 :with => "johndoe@gmail.com"
    fill_in "Password",              :with => "asdfasdf"
    fill_in "Password confirmation", :with => "asdfasdf"

    click_button "Sign up"

    page.should have_content("Welcome! You have signed up successfully.")
  end

  describe "user sign in" do
    it "allows users to sign in after they have registered" do
      user = User.create(
        :first_name => "John",
        :last_name => "Doe",
        :email    => "johndoe@gmail.com",
        :password => "asdfasdf")

      visit "/users/sign_in"

      fill_in "First name", :with => "John"
      fill_in "Last name",  :with => "Doe"
      fill_in "Email",      :with => "johndoe@gmail.com"
      fill_in "Password",   :with => "asdfasdf"

      click_button "Log in"

      page.should have_content("Signed in successfully.")
    end
  end
end