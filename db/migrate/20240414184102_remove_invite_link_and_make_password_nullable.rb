# db/migrate/[timestamp]_remove_invite_link_and_make_password_nullable.rb

class RemoveInviteLinkAndMakePasswordNullable < ActiveRecord::Migration[6.0]
  def change
    remove_column :boards, :invite_link, :string
    change_column_null :boards, :password, true
  end
end
