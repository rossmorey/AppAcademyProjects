require 'spec_helper'
require 'rails_helper'

feature "Auth Integration Tests" do
  feature "the signup process" do
    scenario "has a new user page" do
      visit new_user_url
      expect(page).to have_content "New User"
    end

    feature "signing up a user" do

      scenario "shows username on the homepage after signup" do
        visit new_user_url
        fill_in 'Username', with: 'johnmclain'
        fill_in 'Password', with: 'diehard'
        click_on "Sign Up"
        expect(page).to have_content "johnmclain"
      end
    end
  end

  feature "logging in" do
    User.create(username: 'johnmclain', password: 'diehard')

    scenario "shows username on the homepage after login" do
      visit new_session_url
      login_for_spec
      expect(page).to have_content "johnmclain"
    end
  end

  feature "logging out" do
    scenario "begins with a logged out state" do
      visit new_session_url
      expect(page).to have_content "Sign In"
    end

    scenario "doesn't show username on the homepage after logout" do
      visit new_session_url
      login_for_spec
      click_on "Log Out"
      expect(page).to_not have_content "johnmclain"
    end
  end
end
