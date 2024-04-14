class AddBoardFeaturesToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :password_digest, :string
    add_column :boards, :invite_link, :string
  end
end
