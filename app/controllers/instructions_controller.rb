class InstructionsController < ApplicationController
	
	def index
		if params[:tag]
			@instructions = Instruction.tagged_with(params[:tag]).eager_load(:tags)
		else		
			@instructions = Instruction.all.eager_load(:tags)
		end	
		@categories = Category.select("id, name")
	end

	def new
		p params
		@instruction = current_user.instructions.new
		@categories = Category.select("id, name")
		p @categories
	end

	def create
		@instruction = current_user.instructions.new instruction_params
		# p params	
		if @instruction.save 
		 redirect_to instruction_steps_path(@instruction.id), :notice => "creating steps!" 
		else
			render 'new', :notice => "instruction was not save!"
		end	
	end

	def edit
		@instruction = set_instruction
		@steps = @instruction.steps
		@categories = Category.select("id, name")
		@instruction_tags = parse_tags
	end

	def update
		@instruction = Instruction.find(params[:id])
    p params
    if @instruction.update_attributes(instruction_params)
      redirect_to instruction_path(@instruction.id), :notice => "successfully update!" 
    	# save_steps_numbers
    else
    	puts @instruction.errors
      render 'edit'
    end
	end

	def show
			p current_user
			@instruction = Instruction.eager_load(:steps, :tags).where(id: params[:id]).to_a.first
			@category = Category.find(@instruction.category_id)
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

	def parse_tags
		result = []
		@instruction.tags.each do |t|
			result.push(t.name)
		end
		result.join(',')
	end

	def instruction_params
		params.require(:instruction).permit(
			:name, :video_url, :category_id, :tag_list,
			steps_attributes: [:id, :number]
		)
	end


end
