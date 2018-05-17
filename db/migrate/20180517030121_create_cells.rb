class CreateCells < ActiveRecord::Migration[5.2]
  def change
    create_table :cells do |t|
      t.integer :value, default: 0
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
