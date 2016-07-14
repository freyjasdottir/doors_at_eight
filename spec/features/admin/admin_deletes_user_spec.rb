require 'rails_helper'

feature 'Admin deletes a user' do
  scenario 'Admin deletes a user' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, role: "admin")

    login_user(admin)
    visit root_path

    click_link 'Admin Section'
    first('.delete-button').click_button('Delete User')

    expect(page).to have_content('User deleted')
    expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario 'Non-admin is rejected from viewing user index' do
    member = FactoryGirl.create(:user)

    login_user(member)

    expect { visit admin_users_path(member.id) }.
      to raise_error(ActionController::RoutingError)
  end
end
