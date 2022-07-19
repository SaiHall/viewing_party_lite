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

  it 'has list of existing users if logged in to view' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: 'no-u', password_confirmation: 'no-u')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

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

  it 'each existing user shows an email when logged in' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: 'no-u', password_confirmation: 'no-u')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/'
    expect(page).to have_content("Sai")
    expect(page).to have_content("Deannah")
    expect(page).to have_content("SaiLent@overlord.com")
    expect(page).to have_content("DMB@donuts.com")
  end

  it 'has a link to the log in page' do
    visit '/'

    expect(page).to have_link("Log In")

    click_link("Log In")
    expect(page).to have_current_path('/login')
  end

  it 'has a logout option if a user is logged in' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/'

    expect(page).to have_link("Log Out")
    expect(page).to_not have_link("Log In")
  end

  it 'clicking log out link will log out the current user' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    visit '/login'

    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'no-u'
    click_button("Log In")

    visit '/'

    click_link("Log Out")
    expect(page).to have_current_path('/')
    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
  end

  it 'will not show all users to a visitor' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    user2 = User.create!(name: 'Deannah', email: 'DMB@donuts.com', password: 'no-u', password_confirmation: 'no-u')

    visit '/'
    expect(page).to_not have_content("Existing Users")
    expect(page).to_not have_content("Sai")
    expect(page).to_not have_content("Deannah")
  end
end
