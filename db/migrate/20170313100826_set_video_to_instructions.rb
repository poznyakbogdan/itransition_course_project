class SetVideoToInstructions < ActiveRecord::Migration[5.0]
  def change
  	@instructions = Instruction.all
  	@instructions.each do |instruction|
  		instruction.video_url = "https://www.youtube.com/watch?v=OwZsT6NVET4"
  		instruction.save
  	end
  end
end
