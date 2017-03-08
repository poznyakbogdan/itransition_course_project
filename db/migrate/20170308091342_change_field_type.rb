class ChangeFieldType < ActiveRecord::Migration[5.0]
  
  def up
  	change_table :instructions do |t|
  		instructions = Instruction.select("id, user_id")
  		t.remove :user_id
  		t.integer :user_id
  		instructions.each do |i|
  			instruction = Instruction.find(i.id)
  			instruction.user_id = i.user_id.to_i
  			instruction.save 
  		end
  	end
  end

  def down
  	change_table :instructions do |t|
  		instructions = Instruction.select("id, user_id")
  		t.remove :user_id
  		t.string :user_id
  		instructions.each do |i|
  			instruction = Instruction.find(i.id)
  			instruction.user_id = i.user_id.to_s
  			instruction.save 
  		end
  	end
  end

end
