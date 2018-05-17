class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :password

  has_many :games
end
