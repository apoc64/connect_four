require 'rails_helper'

describe Trophy, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:image)}
  end

  describe 'relationships' do
    it {should have_many(:users).through(:user_trophies)}
  end
end
