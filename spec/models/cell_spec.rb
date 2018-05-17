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

  describe 'output messages' do
    it 'can output alternate text when empty' do
      cell = Cell.new
      expect(cell.alt).to eq('empty')
    end

    it 'can output alternate text when empty' do
      cell = Cell.new
      cell.update(value: 1)
      expect(cell.alt).to eq('red')
    end

    it 'can output alternate text when empty' do
      cell = Cell.new
      call.update(value: 2)
      expect(cell.alt).to eq('black')
    end
  end
end
