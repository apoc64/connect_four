class Game <ApplicationRecord
  validates_presence_of :status
  has_many :cells

  def self.create_game
    game = Game.create
    16.times do
      game.cells.create
    end
    game
  end
end
