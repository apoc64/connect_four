class Game < ApplicationRecord
  validates_presence_of :status
  has_many :cells, dependent: :destroy
  belongs_to :user

  def self.create_game(user)
    game = user.games.create
    16.times do
      game.cells.create
    end
    game
  end

  def alt
    return 'In Progress' if status.zero?
    return 'Win' if status == 1
    return 'Loss' if status == 2
    return 'Draw' if status == 3
  end

  def ordered_cells
    cells.order(:id)
  end

  COLUMNS = [[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]]

  def drop(column, player)
    spaces = COLUMNS[column]
    return false if ordered_cells[spaces[0]].value != 0
    spaces.each_with_index do |space, index|
      if index == 3
        ordered_cells[space].update(value: player)
        return true
      elsif ordered_cells[spaces[index + 1]].value != 0
        ordered_cells[space].update(value: player)
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
      won = (1..3).all? do |i| #AR method for all?
        (ordered_cells[combo[i]].value == ordered_cells[combo[i - 1]].value) && (ordered_cells[combo[1]].value != 0)
      end
      return true if won
    end
    false
  end

  def check_full
    ordered_cells.none? do |cell|
      cell.value == 0
    end
  end

  def move(column)
    return false unless drop(column, 1) # pick a different column
    return true if game_over_after_move(1)
    computer_turn = drop(rand(4), 2) until computer_turn
    game_over_after_move(2)
    true
  end

  def game_over_after_move(player)
    if check_win
      update(status: player)
      return true
    end
    if check_full
      update(status: 3)
      return true
    end
    false
  end

end
