require 'rails_helper'

describe 'visitor' do
  it 'can log in' do
    name = 'bob'
    password = '1234'
    user = User.create!(name: name, password: '1234')

    visit login_path

    fill_in :name, with: name
    fill_in :password, with: password
    click_on 'Log On'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Hello, #{name}")
  end

  it 'can log out' do
    name = 'bob'
    password = '1234'
    user = User.create!(name: name, password: '1234')

    visit login_path

    fill_in :name, with: name
    fill_in :password, with: password
    click_on 'Log On'
    # expect(current_user).to eq(user)
    expect(page).to_not have_link("Log in")
    expect(current_path).to eq(user_path(user))

    click_on 'Log out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_link("Log out")
    # expect(current_user).to eq(nil)
  end
end
