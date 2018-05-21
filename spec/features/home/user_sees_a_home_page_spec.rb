require 'rails_helper'

describe 'User' do
  it 'sees a nav' do
    visit root_path

    expect(page).to have_content('Connect 4!')
    expect(page).to have_link(href: login_path)
    expect(page).to have_link(href: new_user_path)
    # empty game board
  end
end
