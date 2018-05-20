require 'rails_helper'

describe 'user visits user show page' do
  it 'can create a new game' do
    user = User.create(name: 'bob', password: '1234')

    visit user_path(user)

    click_on 'Start New Game'

    expect(current_path).to eq(user_game_path(user, user.games.last))
  end
end
