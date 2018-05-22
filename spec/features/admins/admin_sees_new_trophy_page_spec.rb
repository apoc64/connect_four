require 'rails_helper'

describe 'User visits trophies index' do
  context 'as admin' do
    it 'allows admin to create a trophy' do
      admin = User.create!(name: 'bob', password: '1234', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit new_admin_trophy_path

      expect(page).to have_content('Create A Trophy')

      fill_in 'trophy[name]', with: "boom"
      fill_in 'trophy[description]', with: "boom boom"
      fill_in 'trophy[image]', with: "/boom.jpg"
      click_on 'Create Trophy'

      expect(current_path).to eq(admin_trophy_path(Trophy.last))
      expect(page).to have_content(Trophy.last.name)
      expect(page).to have_content(Trophy.last.description)
      # expect(page).to have_content(Trophy.last.image)
    end

    xit 'fails to create with blank fields' do
    end
  end

  context 'as a default user' do
    it 'does not allow' do
      user = User.create(name: 'bob', password: '1234')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_trophy_path
      message = "These are not the droids you're looking for"

      expect(page).to have_content(message)
      expect(page).to_not have_content('Create A Trophy')
    end
  end
end
