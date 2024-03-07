class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :pname
      t.text :pdesc
      t.string :pimage
      t.string :plink
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
