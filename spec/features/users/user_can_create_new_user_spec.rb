require 'rails_helper'

describe 'user visits new user page' do
  it 'submitting valid form creates new user and logs them in' do
    visit new_user_path

    name = 'bob'
    fill_in 'user[name]', with: name
    fill_in 'user[password]', with: '1234'

    expect(page).to have_link('Log in')
    expect(page).to_not have_link('Log out')

    click_button 'Create'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content("Hello, #{name}")
    expect(page).to have_link('Log out')
    expect(page).to_not have_link('Log in')
  end

  it 'fails on blank field' do
    visit new_user_path

    name = 'bob'
    fill_in 'user[name]', with: name
    click_button 'Create'

    message = 'User creation failed'

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content(message)
  end

  it 'fails on non-unique name' do
    visit new_user_path

    name = 'bob'
    password = '1234'
    user1 = User.create(name: name, password: password)
    fill_in 'user[name]', with: name
    fill_in 'user[password]', with: '12345'
    click_button 'Create'

    message = 'User creation failed'

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content(message)
  end
end
