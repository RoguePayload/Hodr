class AddCustomizationsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :background_image, :string
    add_column :users, :background_music, :string
    add_column :users, :background_color, :string
    add_column :users, :heading_font, :string
    add_column :users, :paragraph_font, :string
    add_column :users, :hyperlink_font, :string
    add_column :users, :heading_color, :string
    add_column :users, :paragraph_color, :string
    add_column :users, :hyperlink_color, :string
    add_column :users, :twitch_affiliation, :string
    add_column :users, :youtube_affiliation, :string
    add_column :users, :premium_user, :boolean, default: false
    add_column :users, :box_shadow, :boolean, default: false
    add_column :users, :box_shadow_color, :string
    add_column :users, :privacy, :boolean, default: false
    add_column :users, :verification_badge, :string
    add_column :users, :admin_badge, :string
    add_column :users, :button_color, :string
    add_column :users, :button_outline, :string
  end
end
