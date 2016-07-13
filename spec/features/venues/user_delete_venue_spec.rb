require 'rails_helper'

feature 'Delete a venue' do
  let(:venue) { FactoryGirl.create(:venue) }
  let(:user) { FactoryGirl.create(:user) }
  let(:t_is_accessible_string) { 'T is nearby' }

  before do
    login_user(user)
    visit venue_path(venue)
  end

  scenario 'User does not see Delete button' do
    expect(page).not_to have_content('Delete')
  end
end
