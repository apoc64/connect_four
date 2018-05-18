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

  COLUMNS = [[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]]

  def drop(column, player)
    spaces = COLUMNS[column]
    return false if cells[spaces[0]].value != 0
    spaces.each_with_index do |space, index|
      if index == 3
        cells[space].update(value: player)
        return true
      elsif cells[spaces[index + 1]].value != 0
        cells[space].update(value: player)
        return true
      end
    end
  end

  def check_win
    false
  end
end
