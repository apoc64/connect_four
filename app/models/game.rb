class Game <ApplicationRecord
  validates_presence_of :status
  has_many :cells
end
