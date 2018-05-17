require 'rails_helper'

describe Game, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:status)}
  end

  describe 'relationships' do
    it {should have_many(:cells)}
  end

  describe 'default state' do
    it 'has a default status of 0' do
      game = Game.create
      expect(game.status).to eq(0)
    end
    it 'has 16 cells with create_game method' do
      game = Game.create_game
      expect(game.cells.count).to eq(16)
    end
  end
end
