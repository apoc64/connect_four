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
  end
end
