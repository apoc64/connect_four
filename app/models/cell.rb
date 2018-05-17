class Cell < ApplicationRecord
  validates_presence_of :value
  belongs_to :game
end
