require 'rails_helper'

describe 'User visits admin trophies page' do
  context 'as admin' do
    it 'shows all trophies' do
      admin = User.create(name: 'bob', password: '1234', role: 1)
      trophy1 = Trophy.create(name: 'boom', description: 'boom boom', image: '/boom.jpg')
      trophy2 = Trophy.create(name: 'doom', description: 'doom doom', image: '/doom.jpg')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_trophies_path

      expect(page).to have_content("All Trophies")
      expect(page).to have_content(trophy1.name)
      expect(page).to have_content(trophy2.name)
    end
  end
end
