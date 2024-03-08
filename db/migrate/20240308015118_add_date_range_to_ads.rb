class AddDateRangeToAds < ActiveRecord::Migration[7.0]
  def change
    add_column :ads, :start_date, :date
    add_column :ads, :end_date, :date
  end
end
