class InstructionsController < StepsController
	
	def index
		@instructions = Instruction.all
	end

	def new
		p params
		@instruction = current_user.instructions.new
	end

	def create
		@instruction = current_user.instructions.new instruction_params
		# p params	
		if @instruction.save 
		 redirect_to instruction_steps_path(@instruction.id), :notice => "creating sreps!" 
		else
			render 'new', :notice => "instruction was not save!"
		end	
	end

	def edit
		@instruction = set_instruction
	end

	def update
		@instruction = Instruction.find(params[:id])
    p params
    if @instruction.update_attributes(instruction_params)
      # redirect_to instruction_path(@instruction.id), :notice => "successfully update!" 
    	save_steps_numbers
    else
      render 'edit'
    end
	end

	def show
			@instruction = Instruction.eager_load(:steps).where(id: params[:id]).to_a.first
	end

	def destroy
		@instruction = Instruction.eager_load(:steps).where(id: params[:id]).to_a.first
		if @instruction.destroy
			puts "successfully"
			redirect_to user_path current_user.id
		else
			puts "alert"
		end	
	end

	private

	def instruction_params
		params.require(:instruction).permit(:name, :video_url)
	end


end
