require 'rails_helper'
#save_and_open_page

RSpec.describe "User Registration Page", type: :feature do
  # before :each do
  #   user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com')
  # end

  it 'has a form' do
    visit "/register"
    expect(page).to have_field(:name)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_field(:password_confirmation)
    expect(page).to have_button("Register")
  end

  it 'can register a new user' do
    visit "/register"

    fill_in :name, with: 'Casey'
    fill_in :email, with: 'EternalPancakes@Geemail.com'
    fill_in :password, with: 'LetMeIn'
    fill_in :password_confirmation, with: 'LetMeIn'
    click_button("Register")

    last_user = User.all.last

    expect(page).to have_current_path("/dashboard")
    expect(page).to_not have_content('Please enter a valid name and email address to register.')
  end

  it 'will not register an email that was already used' do
    visit "/register"
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')

    fill_in :name, with: 'Sai Again'
    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'LetMeIn'
    fill_in :password_confirmation, with: 'LetMeIn'
    click_button("Register")

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Email has already been taken")
  end

  it 'will not register a user if the password and confirmation do not match' do
    visit "/register"

    fill_in :name, with: 'Sai Again'
    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'LetMeIn'
    fill_in :password_confirmation, with: 'PleaseLetMeIn'
    click_button("Register")

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'will not register a user if the password is empty' do
    visit "/register"

    fill_in :name, with: 'Sai Again'
    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password_confirmation, with: 'LetMeIn'
    click_button("Register")

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Password can't be blank")
  end

  it 'will not register a user if the name is empty' do
    visit "/register"

    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'LetMeIn'
    fill_in :password_confirmation, with: 'LetMeIn'
    click_button("Register")

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Name can't be blank")
  end

  it 'will not register a user if the email is empty' do
    visit "/register"

    fill_in :name, with: 'Sai Again'
    fill_in :password, with: 'LetMeIn'
    fill_in :password_confirmation, with: 'LetMeIn'
    click_button("Register")

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Email can't be blank")
  end

  it 'will not register a user if the password confirmation is empty' do
    visit "/register"

    fill_in :name, with: 'Sai Again'
    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'LetMeIn'
    click_button("Register")

    expect(page).to have_current_path('/register')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
