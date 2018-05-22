require 'rails_helper'

describe 'user visits user show page' do
  it 'throws a 404 if not logged in' do
    user = User.create(name: 'bob', password: '1234')

    visit user_path(user)
    message = "These are not the droids you're looking for"

    expect(page).to have_content(message)
  end

  it 'throws a 404 if not the correct user' do
    user1 = User.create(name: 'bob', password: '1234')
    user2 = User.create(name: 'blob', password: '1234')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit user_path(user2)
    message = "These are not the droids you're looking for"

    expect(page).to have_content(message)
  end

  it 'shows a message if the right user logged in' do
    name = 'bob'
    user = User.create(name: name, password: '1234')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_content("Hello, #{name}")
  end

  it 'can create a new game' do
    user = User.create(name: 'bob', password: '1234')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit user_path(user)

    click_on 'Start New Game'

    expect(current_path).to eq(user_game_path(user, user.games.last))
  end

  it 'can show number of games by status' do
    user = User.create(name: 'bob', password: '1234')
    g1 = user.create_game
    g1.update(status: 1)
    g2 = user.create_game
    g2.update(status: 1)
    g3 = user.create_game
    g3.update(status: 1)
    g4 = user.create_game
    g4.update(status: 2)
    g5 = user.create_game
    g5.update(status: 2)
    g6 = user.create_game
    g6.update(status: 3)
    user.create_game
    user.create_game
    user.create_game
    user.create_game

    message1 = "Wins: 3"
    message2 = "Losses: 2"
    message3 = "Draws: 1"
    message4 = "In Progress: 4"
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit user_path(user)

    expect(page).to have_content(message1)
    expect(page).to have_content(message2)
    expect(page).to have_content(message3)
    expect(page).to have_content(message4)
  end
end
