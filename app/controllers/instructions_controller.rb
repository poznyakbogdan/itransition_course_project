class InstructionsController < ApplicationController
	
	# load_and_authorize_resource :through => :current_user
	load_and_authorize_resource param_method: :instruction_params
	# before_action :set_instruction, only: [:upvote, :downvote]

	def text_search
		@instructions = Instruction.search(params[:search])
	end

	def index
		if params[:tag]
			@instructions = Instruction.paginate(:page => params[:page]).tagged_with(params[:tag]).eager_load(:tags, :category).order(:cached_votes_score => :desc)
		else		
			@instructions = Instruction.all.paginate(:page => params[:page]).eager_load(:tags, :category).order(:cached_votes_score => :desc)
		end	
		# @instruction.paginate(:page => params[:page])
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
		authorize! :create, @instruction
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
		@instruction_tags = parse_tags(@instruction.tags)
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
			@instruction = Instruction.eager_load(:steps, :tags, :category).where(id: params[:id]).to_a.first
			@comments = Comment.where(step_id: @instruction.steps.ids).eager_load(:user).to_a
			respond_to do |format|
				format.html
				format.pdf do
					pdf = InstructionPdf.new(@instruction)
					
					send_data pdf.render, filename: "instruction_#{@instruction.id}.pdf",
																type: "application/pdf",
																disposition: "inline"
				end
			end
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

	def tag_name_list
		tags = ActsAsTaggableOn::Tag.all.select("name").order(:name)
		# p @tags
		respond_to do |format|
			format.json { render json: tags }
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

	def parse_tags(tags)
		result = []
		tags.each do |t|
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
