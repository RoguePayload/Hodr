class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uname
      t.string :fname
      t.string :mname
      t.string :lname
      t.string :tel
      t.string :email
      t.string :adr1
      t.string :adr2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :git
      t.string :twitter
      t.string :lin
      t.string :web
      t.string :ytube
      t.string :degree
      t.string :sname
      t.string :marital
      t.string :spouse
      t.string :kids
      t.string :books
      t.string :movies
      t.string :activity
      t.string :songs
      t.string :games
      t.string :jtitle
      t.string :cname
      t.string :ljob

      t.timestamps
    end
  end
end
