class AddPasswordToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :password, :string
  end
end
