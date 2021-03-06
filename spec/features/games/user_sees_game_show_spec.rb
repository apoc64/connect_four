require 'rails_helper'

describe 'user visits the game show page' do
  it 'throws a 404 if user not logged in' do
    user = User.create(name: 'bob', password: '1234')
    game = user.create_game

    visit user_game_path(user, game)
    message = "These are not the droids you're looking for"

    expect(page).to have_content(message)
  end

  it 'throws a 404 if user is not the logged in user' do
    user1 = User.create(name: 'bob', password: '1234')
    user2 = User.create(name: 'blob', password: '1234')
    game = user2.create_game

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit user_game_path(user2, game)
    message = "These are not the droids you're looking for"

    expect(page).to have_content(message)
  end

  it 'throws a 404 if game does not belong to user' do
    user1 = User.create(name: 'bob', password: '1234')
    user2 = User.create(name: 'blob', password: '1234')
    game = user2.create_game

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit user_game_path(user1, game)
    message = "These are not the droids you're looking for"

    expect(page).to have_content(message)
  end

  it 'shows game if user is logged in and game is valid' do
    user1 = User.create(name: 'bob', password: '1234')
    user2 = User.create(name: 'blob', password: '1234')
    game = user2.create_game

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit user_game_path(user2, game)

    expect(current_path).to eq(user_game_path(user2, game))
    expect(page).to have_content("Good Luck")
  end

  it 'starts with an empty board' do
    user = User.create(name: 'bob', password: '1234')
    game = user.create_game

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_game_path(user, game)

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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit user_game_path(user, game)

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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit user_game_path(user, game)
      # within('.column0') do
        click_on 'Drop1'
      # end
      message1 = 'Square 13 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(user_game_path(user, game))
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit user_game_path(user, game)
      # within('.column1') do
        click_on 'Drop2'
      # end
      message1 = 'Square 14 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(user_game_path(user, game))
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit user_game_path(user, game)
      # within('.column2') do
        click_on 'Drop3'
      # end
      message1 = 'Square 15 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(user_game_path(user, game))
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit user_game_path(user, game)
      # within('.column2') do
        click_on 'Drop4'
      # end
      message1 = 'Square 16 is red'
      message2 = 'is black'
      message7 = 'Square 7 is empty'

      expect(current_path).to eq(user_game_path(user, game))
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit user_game_path(user, game)

      click_on 'Start New Game'

      expect(current_path).to eq(user_game_path(user, Game.last))
      expect(current_path).to_not eq(user_game_path(user, game))
      message1 = 'is red'
      message2 = 'is black'

      expect(page).to_not have_content(message1)
      expect(page).to_not have_content(message2)
    end
  end
end
