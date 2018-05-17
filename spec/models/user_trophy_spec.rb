require 'rails_helper'

describe UserTrophy, type: :model do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:trophy)}
  end
end
