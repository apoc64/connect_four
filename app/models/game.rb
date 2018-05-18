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

  WINNING_COMBOS = [[0, 1, 2, 3], [4, 5, 6, 7],
                  [8, 9, 10, 11], [12, 13, 14, 15],
                  [0, 4, 8, 12], [1, 5, 9, 13],
                  [2, 6, 10,14], [3, 7, 11, 15],
                  [0, 5, 10, 15], [3, 6, 9, 12]]

  def check_win
    WINNING_COMBOS.each do |combo|
      won = (1..3).all? do |i|
        (cells[combo[i]].value == cells[combo[i - 1]].value) && (cells[combo[1]].value != 0)
      end
      return true if won
    end
    false
  end
end
