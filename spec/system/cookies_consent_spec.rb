require "rails_helper"

describe "Cookies Consent" do
  context "User not logged in" do
    scenario "Show by default" do
      visit root_path
      expect(page).to have_css ".cookies-eu"
    end

    scenario "Hide when accepted" do
      visit root_path
      within(".cookies-eu") do
        click_button "OK"
      end
      visit root_path
      expect(page).not_to have_css ".cookies-eu"
    end
  end

  context "User logged in" do
    scenario "Show by default" do
      user = create(:user)
      login_as(user)
      visit root_path
      expect(page).to have_css ".cookies-eu"
    end

    scenario "Hide when accepted after login" do
      user = create(:user)
      login_as(user)
      visit root_path
      within(".cookies-eu") do
        click_button "OK"
      end
      expect(page).not_to have_css ".cookies-eu"
    end

    scenario "Do not show again when loggin out if accepted while login" do
      user = create(:user)
      login_as user
      visit root_path
      within(".cookies-eu") do
        click_button "OK"
      end
      expect(page).not_to have_css ".cookies-eu"
      logout
      expect(page).not_to have_css ".cookies-eu"
    end

    scenario "Do not show again when accepted before login" do
      visit root_path
      within(".cookies-eu") do
        click_button "OK"
      end
      expect(page).not_to have_css ".cookies-eu"
      user = create(:user)
      login_as user
      visit root_path
      expect(page).not_to have_css ".cookies-eu"
      logout
      expect(page).not_to have_css ".cookies-eu"
    end
  end
end
