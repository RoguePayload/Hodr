class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :avatar
      t.string :description

      t.timestamps
    end
  end
end
