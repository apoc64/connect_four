require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:password)}
    # it {should validate_uniqueness_of(:name)}
    # it {should have_secure_password}
  end

  describe 'relationships' do
    it {should have_many(:games)}
    it {should have_many(:trophies).through(:user_trophies)}
  end

  describe 'create game' do
    it 'can create a game with proper default state' do
      user = User.create(name: 'bob', password: '1234')

      game = user.create_game

      expect(user.games.first).to eq(game)
      expect(game.status).to eq(0)
      expect(game.cells.count).to eq(16)
      expect(game.cells[0].value).to eq(0)
      expect(game.cells[9].value).to eq(0)
    end
  end
end
