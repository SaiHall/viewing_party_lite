require 'rails_helper'

RSpec.describe 'the landing page', type: :feature do
  it 'displays name of the app' do
    visit '/'

    expect(page).to have_content("Viewing Party Lite")
  end

  it 'has button to create new user' do
    visit '/'

    expect(page).to have_button("Create New User")
    click_button("Create New User")
    expect(page).to have_current_path("/register")
  end

  it 'has list of existing users' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: 'no-u', password_confirmation: 'no-u')

    visit '/'
    expect(page).to have_content("Existing Users")
      within "#user-0" do
        expect(page).to have_content("Sai")
        expect(page).to_not have_content("Deannah")
      end

      within "#user-1" do
        expect(page).to have_content("Deannah")
        expect(page).to_not have_content("Sai")
      end
    end

  it 'each existing user links to user dashboard' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: 'no-u', password_confirmation: 'no-u')

    visit '/'
    click_link("Sai's Dashboard")
    expect(current_path).to eq("/users/#{user1.id}")
    expect(current_path).to_not eq("/users/#{user2.id}")
  end

  it 'has a link to the log in page' do
    visit '/'

    expect(page).to have_link("Log In")

    click_link("Log In")
    expect(page).to have_current_path('/login')
  end
end
