class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :password

  has_many :games
  has_many :trophies, through: :user_trophies
  has_many :user_trophies

  def create_game
    Game.create_game(self)
  end
end
