require 'rails_helper'

xdescribe 'user visits high scores page' do
  it 'sees high scores' do
    user1 = User.create(name: 'bob', password: '1234')
    user1.games.create(status: 1)
    user2 = User.create(name: 'blob', password: '1234')
    user2.games.create(status: 0)

    visit users_path

    expect(page).to have_content(user1.name)
    expect(page).to_not have_content(user2.name)
  end
end
