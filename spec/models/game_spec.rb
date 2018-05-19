require 'rails_helper'

describe Game, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'relationships' do
    it {should have_many(:cells)}
    it {should belong_to(:user)}
  end

  describe 'default state' do
    it 'has a default status of 0' do
      user = User.create(name: 'bob', password: '1234')
      game = user.games.create
      expect(game.status).to eq(0)
    end

    it 'has 16 cells with create_game method' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      expect(game.cells.count).to eq(16)
    end
  end

  describe 'alt status' do
    it 'can show a string for its status' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      message1 = 'In Progress'
      message2 = 'Win'
      message3 = 'Loss'

      expect(game.alt).to eq(message1)

      game.update(status: 1)
      expect(game.alt).to eq(message2)

      game.update(status: 2)
      expect(game.alt).to eq(message3)
    end
  end

  describe 'dropping piece in column' do
    it 'dropping piece in column goes to bottom' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      result = game.drop(0, 1) #(column, player)

      expect(result).to eq(true)
      expect(game.cells[12].value).to eq(1)
      expect(game.cells[12].alt).to eq('red')
      expect(game.cells[13].value).to eq(0)
      expect(game.cells[13].alt).to eq('empty')
      expect(game.cells[8].value).to eq(0)
      expect(game.cells[8].alt).to eq('empty')
      expect(game.cells[14].value).to eq(0)
      expect(game.cells[14].alt).to eq('empty')
      expect(game.cells[15].value).to eq(0)
      expect(game.cells[15].alt).to eq('empty')

      result = game.drop(2, 2)
      expect(result).to eq(true)
      expect(game.cells[12].value).to eq(1)
      expect(game.cells[12].alt).to eq('red')
      expect(game.cells[13].value).to eq(0)
      expect(game.cells[13].alt).to eq('empty')
      expect(game.cells[8].value).to eq(0)
      expect(game.cells[8].alt).to eq('empty')
      expect(game.cells[14].value).to eq(2)
      expect(game.cells[14].alt).to eq('black')
      expect(game.cells[15].value).to eq(0)
      expect(game.cells[15].alt).to eq('empty')
    end

    it 'dropping pieces can stack' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      game.drop(0, 1) #(column, player)
      result = game.drop(0, 2)

      expect(result).to eq(true)
      expect(game.cells[12].value).to eq(1)
      expect(game.cells[12].alt).to eq('red')
      expect(game.cells[13].value).to eq(0)
      expect(game.cells[13].alt).to eq('empty')
      expect(game.cells[8].value).to eq(2)
      expect(game.cells[8].alt).to eq('black')
      expect(game.cells[14].value).to eq(0)
      expect(game.cells[14].alt).to eq('empty')
      expect(game.cells[15].value).to eq(0)
      expect(game.cells[15].alt).to eq('empty')

      game.drop(2, 2)
      result = game.drop(2, 1)

      expect(result).to eq(true)
      expect(game.cells[12].value).to eq(1)
      expect(game.cells[12].alt).to eq('red')
      expect(game.cells[13].value).to eq(0)
      expect(game.cells[13].alt).to eq('empty')
      expect(game.cells[8].value).to eq(2)
      expect(game.cells[8].alt).to eq('black')
      expect(game.cells[14].value).to eq(2)
      expect(game.cells[14].alt).to eq('black')
      expect(game.cells[10].value).to eq(1)
      expect(game.cells[10].alt).to eq('red')
    end

    it 'when stacked 4 high drop returns false and changes no cells' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      game.drop(0, 1) #(column, player)
      game.drop(0, 2)
      game.drop(0, 1)
      result = game.drop(0, 2)

      expect(result).to eq(true)
      expect(game.cells[12].value).to eq(1)
      expect(game.cells[12].alt).to eq('red')
      expect(game.cells[8].value).to eq(2)
      expect(game.cells[8].alt).to eq('black')
      expect(game.cells[4].value).to eq(1)
      expect(game.cells[4].alt).to eq('red')
      expect(game.cells[0].value).to eq(2)
      expect(game.cells[0].alt).to eq('black')

      result = game.drop(0, 2)

      expect(result).to eq(false)
      expect(game.cells[12].value).to eq(1)
      expect(game.cells[12].alt).to eq('red')
      expect(game.cells[13].value).to eq(0)
      expect(game.cells[13].alt).to eq('empty')
      expect(game.cells[8].value).to eq(2)
      expect(game.cells[8].alt).to eq('black')
      expect(game.cells[1].value).to eq(0)
      expect(game.cells[1].alt).to eq('empty')
      expect(game.cells[0].value).to eq(2)
      expect(game.cells[0].alt).to eq('black')
    end
  end

  describe 'evaluating wins' do
    it 'evaluates no win when board is blank' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      result = game.check_win

      expect(result).to eq(false)
    end

    it 'can evaluate a win on bottom row' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)

      game.drop(0, 1)
      game.drop(1, 1)
      game.drop(2, 1)
      game.drop(3, 1)

      result = game.check_win

      expect(result).to eq(true)
    end

    it 'can evaluate a win on a coulmn with other colors elsewhere' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)

      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(0, 1)
      game.drop(2, 2)
      game.drop(2, 1)
      game.drop(2, 2)
      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(0, 1)

      result = game.check_win

      expect(result).to eq(true)
    end

    it 'evaluates no win on a complex board' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)

      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(2, 1)
      game.drop(3, 2)
      game.drop(1, 1)
      game.drop(0, 2)
      game.drop(2, 1)
      game.drop(3, 2)
      game.drop(0, 1)
      game.drop(2, 2)
      game.drop(1, 1)
      game.drop(2, 2)
      game.drop(3, 1)
      game.drop(0, 2)
      game.drop(3, 1)
      game.drop(1, 2)
      #use this game to test full borad

      result = game.check_win

      expect(result).to eq(false)
    end
  end

  describe 'evaluating full board' do
    it 'evaluates false when board is blank' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)
      result = game.check_full

      expect(result).to eq(false)
    end

    it 'can evaluate false with pieces on bottom row' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)

      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(2, 1)
      game.drop(3, 2)

      result = game.check_full

      expect(result).to eq(false)
    end

    it 'can evaluate false with one column full' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)

      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(3, 1)
      game.drop(0, 2)
      game.drop(2, 1)
      game.drop(2, 2)
      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(0, 1)

      result = game.check_full

      expect(result).to eq(false)
    end

    it 'evaluates true with a full board' do
      user = User.create(name: 'bob', password: '1234')
      game = Game.create_game(user)

      game.drop(0, 1)
      game.drop(1, 2)
      game.drop(2, 1)
      game.drop(3, 2)
      game.drop(1, 1)
      game.drop(0, 2)
      game.drop(2, 1)
      game.drop(3, 2)
      game.drop(0, 1)
      game.drop(2, 2)
      game.drop(1, 1)
      game.drop(2, 2)
      game.drop(3, 1)
      game.drop(0, 2)
      game.drop(3, 1)
      game.drop(1, 2)

      result = game.check_full

      expect(result).to eq(true)
    end
  end



    # describe move
      # game.move(coulmn) -
        #user drops their choise
        #evaluate win - action?
        #evaluate full
        #computer drops
        #evaluate

        #test placement of white
        #test that one black placed
        #test that -2 empty
        #test player 1 win
        #test computer win
        #test full board

end
