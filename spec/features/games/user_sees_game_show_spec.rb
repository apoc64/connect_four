require 'rails_helper'

describe 'user visits the game show page' do
  it 'starts with an empty board' do
    game = Game.create_game

    visit game_path(game)

    message1 = "Square 1 is empty"
    message7 = "Square 7 is empty"
    message16 = "Square 16 is empty"

    within('.cell1') do
      expect(page).to have_content(message1)
    end
    within('.cell7') do
      expect(page).to have_content(message7)
    end
    within('.cell16') do
      expect(page).to have_content(message16)
    end
  end
end
