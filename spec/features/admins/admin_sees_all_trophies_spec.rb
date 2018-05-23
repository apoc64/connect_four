require 'rails_helper'

describe 'User visits admin trophies page' do
  context 'as admin' do
    it 'shows all trophies' do
      admin = User.create(name: 'bob', password: '1234', role: 1)
      trophy1 = Trophy.create(name: 'boom', description: 'boom boom', image: 'bob_ross.jpg')
      trophy2 = Trophy.create(name: 'doom', description: 'doom doom', image: 'bob_ross.jpg')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_trophies_path

      expect(page).to have_content("All Trophies")
      expect(page).to have_link("Create New Trophy")
      expect(page).to have_content(trophy1.name)
      expect(page).to have_content(trophy2.name)
    end

    it 'can delete trophy' do
      admin = User.create(name: 'bob', password: '1234', role: 1)
      trophy1 = Trophy.create(name: 'boom', description: 'boom boom', image: 'bob_ross.jpg')
      trophy2 = Trophy.create(name: 'doom', description: 'doom doom', image: 'bob_ross.jpg')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_trophies_path
      within(".trophy_#{trophy1.id}") do
        click_link 'Delete'
      end

      expect(page).to_not have_content(trophy1.name)
    end

    it 'can edit trophy' do
      admin = User.create(name: 'bob', password: '1234', role: 1)
      trophy1 = Trophy.create(name: 'boom', description: 'boom boom', image: 'bob_ross.jpg')
      trophy2 = Trophy.create(name: 'doom', description: 'doom doom', image: 'bob_ross.jpg')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_trophies_path
      within(".trophy_#{trophy1.id}") do
        click_link 'Edit'
      end

      expect(current_path).to eq(edit_admin_trophy_path(trophy1))

      fill_in 'trophy[name]', with: 'zoom'

      click_on 'Update Trophy'

      expect(current_path).to eq(admin_trophies_path)
      expect(page).to have_content('zoom')
    end
  end
end
