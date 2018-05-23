class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates_presence_of :password

  has_many :games
  has_many :user_trophies
  has_many :trophies, through: :user_trophies

  has_secure_password

  enum role: [:default, :admin]

  def create_game
    Game.create_game(self)
  end

  def win_trophy
    trophy = Trophy.all.sample
    trophies << trophy
    trophy
  end
end
