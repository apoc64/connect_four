require 'rails_helper'

describe Cell, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:value)}
  end

  describe 'relationships' do
    it {should belong_to(:game)}
  end

  describe 'default_state' do
    it 'should have a default value of zero' do
      cell = Cell.create
      expect(cell.value).to eq(0)
    end
  end
end
