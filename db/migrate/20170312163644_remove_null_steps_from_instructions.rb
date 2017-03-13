class RemoveNullStepsFromInstructions < ActiveRecord::Migration[5.0]
  def change
  	@instructions = Instruction.all
  	@instructions.each do |i|
  		if i.steps.empty?
  			i.destroy
  		else
  		end
  	end	
  end
end
