class AddJDescToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :jdesc, :string
  end
end
