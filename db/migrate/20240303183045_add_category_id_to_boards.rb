class AddCategoryIdToBoards < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :category_id, :integer
  end

  def change
    unless table_exists?(:categories)
      add_column :boards, :category_id, :integer
      end
  end

end
