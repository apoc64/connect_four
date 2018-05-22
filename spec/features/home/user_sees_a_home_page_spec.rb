require 'rails_helper'

describe 'User' do
  it 'sees a nav' do
    visit root_path

    expect(page).to have_content('Connect 4!')
    expect(page).to have_link(href: login_path)
    expect(page).to have_link(href: new_user_path)

    expect(page).to_not have_link(href: logout_path)
    expect(page).to_not have_link("Your Profile")

    expect(page).to_not have_link(href: admin_users_path)
    expect(page).to_not have_link(href: admin_trophies_path)
    # empty game board
  end

  it 'it shows different links when logged in' do
    user = User.create(name: 'bob', password: '1234')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    expect(page).to have_content('Connect 4!')
    expect(page).to_not have_link(href: login_path)
    expect(page).to_not have_link(href: new_user_path)

    expect(page).to have_link(href: logout_path)
    expect(page).to have_link(href: user_path(user))

    expect(page).to_not have_link(href: admin_users_path)
    expect(page).to_not have_link(href: admin_trophies_path)
  end

  it 'it shows admin links for an admin' do
    admin = User.create(name: 'bob', password: '1234', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit root_path

    expect(page).to have_content('Connect 4!')
    expect(page).to_not have_link(href: login_path)
    expect(page).to_not have_link(href: new_user_path)

    expect(page).to have_link(href: logout_path)
    expect(page).to have_link(href: user_path(admin))

    expect(page).to have_link(href: admin_users_path)
    expect(page).to have_link(href: admin_trophies_path)
  end


end
