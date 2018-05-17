class CreateUserTrophies < ActiveRecord::Migration[5.2]
  def change
    create_table :user_trophies do |t|
      t.references :user, foreign_key: true
      t.references :trophy, foreign_key: true
    end
  end
end
