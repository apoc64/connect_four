require 'rails_helper'

describe 'user wins a game' do
  it 'has contratulatory message and gives a trophy' do
    name = 'bob'
    user = User.create(name: name, password: '1234')
    game = user.create_game
    trophy = Trophy.create(name: 'boom', description: 'boom boom', image: 'bob_ross.jpg')

    game.drop(0, 1)
    game.drop(1, 2)
    game.drop(0, 1)
    game.drop(2, 2)
    game.drop(2, 1)
    game.drop(2, 2)
    game.drop(0, 1)
    game.drop(1, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_game_path(user, game)

    click_on 'Drop1'

    expect(current_path).to eq(user_game_path(user, game))
    expect(page).to have_content("Congratulations #{name}!")

    click_on 'Claim Your Trophy'

    expect(current_path).to eq(user_trophy_path(user, user.trophies.last))
  end

  xit 'has losing message' do
    # ...
  end

  xit 'has message for a loss' do
  end
end
