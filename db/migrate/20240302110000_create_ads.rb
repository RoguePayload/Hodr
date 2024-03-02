class CreateAds < ActiveRecord::Migration[7.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.string :subtitle
      t.text :description
      t.string :image_url
      t.string :link_url
      t.integer :display_duration

      t.timestamps
    end
  end
end
