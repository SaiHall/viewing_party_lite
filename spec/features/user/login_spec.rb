require 'rails_helper'

RSpec.describe 'the login page', type: :feature do
  it 'has fields for email and password' do
    visit '/login'

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button("Log In")
  end

  it 'can log a user in and redirect them to their dashboard' do
    user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    visit '/login'

    fill_in :email, with: 'SaiLent@overlord.com'
    fill_in :password, with: 'no-u'
    click_button("Log In")

    expect(page).to have_current_path("/users/#{user1.id}")
  end
end
