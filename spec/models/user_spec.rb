require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it {should have_secure_password}
  end

  describe 'relationships' do
    it {should have_many :viewing_parties}
  end

  describe 'password protection' do
    it 'only has password digest, does not save password or confirmation' do
      sai = User.create(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')

    expect(sai).to_not have_attribute(:password)
    expect(sai.password_digest).to_not eq('no-u')
    end
  end
end
