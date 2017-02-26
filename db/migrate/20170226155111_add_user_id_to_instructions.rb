class AddUserIdToInstructions < ActiveRecord::Migration[5.0]
  def change
    add_column :instructions, :user_id, :string
    add_column :instructions, :integer, :string
  end
end
