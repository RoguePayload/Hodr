class AddIsPremiumToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_premium, :boolean
  end
end
