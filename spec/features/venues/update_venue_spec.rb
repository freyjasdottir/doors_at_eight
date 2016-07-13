require 'rails_helper'

feature 'Update a venue' do
  let(:venue) { FactoryGirl.create(:venue, t_accessible: false) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:t_is_accessible_string) { 'T is nearby' }

  before do
    login_user(admin)
    visit edit_venue_path(venue)
  end

  scenario 'User edits form correctly' do
    fill_in('Name', with: 'Updated Name!')
    fill_in('Capacity', with: '354')
    fill_in('Website', with: 'http://www.venueupdate.com')
    fill_in('Address', with: '45 harrison blvd')
    choose('t_accessible')

    click_button('Save Venue')

    expect(page).to have_content('Updated Name!')
    expect(page).to have_content('354')
    expect(page).to have_content('http://www.venueupdate.com')
    expect(page).to have_content('45 harrison blvd')
    expect(page).to have_content(t_is_accessible_string)

    expect(page).to have_content('Venue saved successfully')
  end

  scenario 'User submits blank form' do
    fill_in('Name', with: '')
    fill_in('Address', with: '')

    click_button('Save Venue')

    expect(page).to have_content('Problems updating venue')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
  end

  scenario 'unauthenticated user cannot edit a venue' do
    logout

    visit edit_venue_path(venue)

    expect(page).to have_content('You need to sign in or sign up before '\
                                 'continuing')
    expect(current_path).to eq(new_user_session_path)
  end
end
