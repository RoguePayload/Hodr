class AddPasswordDigestToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :password_digest, :string
  end
end
