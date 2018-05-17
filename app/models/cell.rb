class Cell < ApplicationRecord
  validates_presence_of :value
  belongs_to :game

  def alt
    if value == 1
      return 'red'
    elsif value == 2
      return 'black'
    else
      return 'empty'
    end
  end
end
