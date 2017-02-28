class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.string :image
      t.text :description
      t.integer :number
      t.integer :instruction_id

      t.timestamps
    end
  end
end
