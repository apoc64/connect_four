require 'rails_helper'

describe 'user visits new user page' do
  it 'submitting valid form creates new user' do
    visit new_user_path

    name = 'bob'
    fill_in 'user[name]', with: name
    fill_in 'user[password]', with: '1234'
    click_button 'Create'

    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content("Hello, #{name}")
  end
end
