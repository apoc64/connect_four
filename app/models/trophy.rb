class Trophy < ApplicationRecord
  validates_presence_of :name, :description, :image

  has_many :user_trophies
  has_many :users, through: :user_trophies
end
