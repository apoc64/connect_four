require 'rails_helper'

describe 'User visits users index' do
  context 'as admin' do
    it 'allows admin to see all users' do
      user = User.create(name: 'blob', password: '1234')
      admin = User.create!(name: 'bob', password: '1234', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_users_path

      expect(page).to have_content(All Users)
      expect(page).to have_content(user.name)
      expect(page).to have_content(admin.name)
    end
  end
end
