class Game <ApplicationRecord
  validates_presence_of :status
  has_many :cells
  belongs_to :user

  def self.create_game(user)
    game = user.games.create
    16.times do
      game.cells.create
    end
    game
  end
end
