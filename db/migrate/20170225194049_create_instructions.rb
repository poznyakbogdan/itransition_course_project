class CreateInstructions < ActiveRecord::Migration[5.0]
  def change
    create_table :instructions do |t|
      t.string :name
      t.string :video_url

      t.timestamps
    end
  end
end
