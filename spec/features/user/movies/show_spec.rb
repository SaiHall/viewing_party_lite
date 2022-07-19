require 'rails_helper'

RSpec.describe "Movie details/show page", type: :feature do
  before :each do
    @user1 = User.create!(name: 'Sai', email: 'SaiLent@overlord.com', password: 'no-u', password_confirmation: 'no-u')
    @user2 = User.create!(name: 'Parker', email: 'GriffithDidNothing@Wrong.com', password: 'no-u', password_confirmation: 'no-u')
  end

  it 'has button to create a viewing party', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    visit "/movies/238"

    expect(page).to have_button("Create Viewing Party")
    expect(page).to have_button("Discover Page")
  end

  it 'discover page button routes to discover page', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)


    visit "/movies/238"

    click_button("Discover Page")

    expect(current_path).to eq("/discover")
  end

  it 'create viewing party button routes to new viewing party page', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    visit "/movies/238"

    click_button("Create Viewing Party")

    expect(current_path).to eq("/movies/238/viewing-party/new")
  end

  it 'displays movie details', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    godfather = MovieFacade.create_movie_details(238)

    visit "/movies/238"

    expect(page).to have_content(godfather.title)
    expect(page).to have_content(godfather.vote_average)
    expect(page).to have_content(godfather.runtime)
    expect(page).to have_content("Drama, Crime")
    expect(page).to have_content(godfather.overview)
  end

  it 'displays cast details', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    godfather_cast = MovieFacade.create_cast(238)

    visit "/movies/238"

    expect(page).to have_content(godfather_cast[0].name)
    expect(page).to have_content(godfather_cast[0].character)
  end

  it 'displays 10 cast members', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)


    visit "/movies/238"

    expect(page.all(".castMember").count).to eq(10)
  end

  it 'displays review author and content', :vcr do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

    godfather_reviews = MovieFacade.create_reviews(129)

    visit "/movies/129"

    within "#ZeBlahReview" do
      expect(page).to have_content(godfather_reviews.paired_reviews[0][:author])
      expect(page).to have_content(godfather_reviews.paired_reviews[0][:content])
    end
  end

  it 'will redirect to the show page if not logged in and new party is clicked', :vcr do
    visit "/movies/238"

    click_button("Create Viewing Party")

    expect(current_path).to eq("/movies/238")
    expect(page).to have_content("Please log in of register to create a viewing party")
  end
end
