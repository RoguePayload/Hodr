class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :jname
      t.text :jdesc
      t.string :jpay
      t.string :jlink
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
