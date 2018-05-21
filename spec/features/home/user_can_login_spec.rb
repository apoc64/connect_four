require 'rails_helper'

describe 'visitor' do
  it 'can log in' do
    name = 'bob'
    password = '1234'
    user = User.create!(name: name, password: '1234')

    visit login_path
    # binding.pry
    # save_and_open_page
    fill_in :name, with: name
    fill_in :password, with: password
    click_on 'Log On'

    expect(current_path).to eq(user_path(user))

  end
end
