class AddCategoryToInstructions < ActiveRecord::Migration[5.0]
  def change
    add_column :instructions, :category_id, :integer
  end
end
