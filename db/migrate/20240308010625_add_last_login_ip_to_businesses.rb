class AddLastLoginIpToBusinesses < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :last_login_ip, :string
  end
end
