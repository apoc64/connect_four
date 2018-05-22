require 'rails_helper'

describe 'user wins a game' do
  it 'redirects to new trophy page' do
    name = 'bob'
    user = User.create(name: name, password: '1234')
    game = user.create_game

    game.drop(0, 1)
    game.drop(1, 2)
    game.drop(0, 1)
    game.drop(2, 2)
    game.drop(2, 1)
    game.drop(2, 2)
    game.drop(0, 1)
    game.drop(1, 2)

    visit user_game_path(user, game)

    click_on 'Drop1'

    expect(current_path).to eq(new_user_trophy_path(user))
    expect(page).to have_content("Congratulations #{name}!")
  end
end
