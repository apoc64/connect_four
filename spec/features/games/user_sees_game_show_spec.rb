require 'rails_helper'

describe 'user visits the game show page' do
  it 'starts with an empty board' do
    user = User.create(name: 'bob', password: '1234')
    game = user.create_game

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

  it 'can show red and black' do
    user = User.create(name: 'bob', password: '1234')
    game = user.create_game

    message1 = 'Square 1 is red'
    game.cells[0].update(value: 1)
    message7 = 'Square 7 is black'
    game.cells[6].update(value: 2)
    message16 = 'Square 16 is red'
    game.cells[15].update(value: 1)

    visit game_path(game)

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

  describe 'user can play the game' do
    it 'can drop in column one' do
      user = User.create(name: 'bob', password: '1234')
      game = user.create_game
      visit game_path(game)

      # within('.column0') do
        click_on 'Drop1'
      # end
      message1 = 'Square 13 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(game_path(game))
      within('.cell13') do
        expect(page).to have_content(message1)
      end
      expect(page).to have_content(message2)
      within('.cell7') do
        expect(page).to have_content(message7)
      end
    end

    it 'can drop in column two' do
      user = User.create(name: 'bob', password: '1234')
      game = user.create_game
      visit game_path(game)

      # within('.column1') do
        click_on 'Drop2'
      # end
      message1 = 'Square 14 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(game_path(game))
      within('.cell14') do
        expect(page).to have_content(message1)
      end
      expect(page).to have_content(message2)
      within('.cell7') do
        expect(page).to have_content(message7)
      end
    end

    it 'can drop in column three' do
      user = User.create(name: 'bob', password: '1234')
      game = user.create_game
      visit game_path(game)

      # within('.column2') do
        click_on 'Drop3'
      # end
      message1 = 'Square 15 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(game_path(game))
      within('.cell15') do
        expect(page).to have_content(message1)
      end
      expect(page).to have_content(message2)
      within('.cell7') do
        expect(page).to have_content(message7)
      end
    end

    it 'can drop in column four' do
      user = User.create(name: 'bob', password: '1234')
      game = user.create_game
      visit game_path(game)

      # within('.column2') do
        click_on 'Drop4'
      # end
      message1 = 'Square 16 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(game_path(game))
      within('.cell16') do
        expect(page).to have_content(message1)
      end
      expect(page).to have_content(message2)
      within('.cell7') do
        expect(page).to have_content(message7)
      end
    end

    # it can win
    # it can lose
    # it can draw
  end

  describe 'create new game' do
    it 'can create new game' do
      user = User.create(name: 'bob', password: '1234')
      game = user.create_game
      visit game_path(game)

      click_on 'Start New Game'

      expect(current_path).to eq(game_path(Game.last))
      expect(current_path).to_not eq(game_path(game))
      message1 = 'is red'
      message2 = 'is black'

      expect(page).to_not have_content(message1)
      expect(page).to_not have_content(message2)
    end
  end
end
