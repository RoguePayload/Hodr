class CreateBusinessFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :business_followers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
