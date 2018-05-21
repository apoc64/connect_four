require 'rails_helper'

describe 'user visits user show page' do
  it 'can create a new game' do
    user = User.create(name: 'bob', password: '1234')

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
    visit user_path(user)

    expect(page).to have_content(message1)
    expect(page).to have_content(message2)
    expect(page).to have_content(message3)
    expect(page).to have_content(message4)
  end
end
