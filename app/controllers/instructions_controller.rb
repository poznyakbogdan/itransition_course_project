class InstructionsController < ApplicationController
	
	def index
		@instructions = current_user.instructions
	end

	def new
		@instruction = current_user.instructions.new
	end

	def create
		@instruction = current_user.instructions.new instruction_params
		
		if @instruction.save 
			redirect_to root_path, :notice => "instruction was save successfully!" 
		else
			render 'new', :notice => "instruction was not save!"
		end	
	end

	def show
	end

	def destroy
	end

	private

	def instruction_params
		params.require(:instruction).permit(:name, :video_url)
	end
end
