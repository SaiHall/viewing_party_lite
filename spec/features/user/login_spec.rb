require 'rails_helper'

RSpec.describe 'the login page', type: :feature do
  it 'has fields for email and password' do
    visit '/login'

    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button("Log In")
  end
end
