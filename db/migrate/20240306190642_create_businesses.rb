class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :website
      t.string :avatar
      t.string :banner
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
