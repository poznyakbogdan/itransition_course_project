class InstructionsController < ApplicationController
	
	# load_and_authorize_resource :through => :current_user
	load_and_authorize_resource param_method: :instruction_params
	# before_action :set_instruction, only: [:upvote, :downvote]

	def index
		if params[:tag]
			@instructions = Instruction.tagged_with(params[:tag]).eager_load(:tags, :category).order(:cached_votes_score => :desc)
		else		
			@instructions = Instruction.all.eager_load(:tags, :category).order(:cached_votes_score => :desc)
		end	
		# @categories = Category.select("id, name")
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
		# @instruction = set_instruction
		@instruction = Instruction.find(params[:id])
		@steps = @instruction.steps
		@categories = Category.select("id, name")
		@instruction_tags = parse_tags
	end

	def update
		@instruction = Instruction.find(params[:id])
    authorize! :update, @instruction
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
		authorize! :destroy, @instruction
		if @instruction.destroy
			puts "successfully"
			redirect_to user_path current_user.id
		else
			puts "alert"
		end	
	end

	def upvote
		@instruction = Instruction.find(params[:id])
		if current_user.liked? @instruction
			@instruction.unliked_by current_user
		else
			@instruction.upvote_from current_user
		end
	end

	def downvote
		@instruction = Instruction.find(params[:id])
		if current_user.disliked? @instruction
			@instruction.undisliked_by current_user
		else
			@instruction.downvote_from current_user
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

	def instructions_redirect
		redirect_to instructions_path
	end

	def my_sanitizer
    params.require(:instruction).permit(:name)
  end

end
