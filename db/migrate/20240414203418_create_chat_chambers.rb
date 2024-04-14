class CreateChatChambers < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_chambers do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :password_digest
      t.string :avatar
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
