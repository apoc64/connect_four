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
end
