class StepsController < ApplicationController

	def index
		@instruction_id = params[:instruction_id]
		@steps = Step.where(instruction_id: @instruction_id).order(:number)	
	end

	def new
		@step = Step.new
	end														

	def save_steps_numbers
		steps = params[:message]
		p params
		Step.transaction do
			steps.each do |key, value|
				Step.connection.update("UPDATE steps SET number='#{value[:number]}' WHERE id=#{key}")
			end
		end
		 redirect_to instruction_path(correct_instruction), :notice => "successfully update!"  
	end																										

	def create
		instruction_id = params[:instruction_id]
		@step = Step.new step_params
		@step.instruction_id = instruction_id
		p params
		if @step.save
			@url = get_image_url		
		else
			render 'index'
		end
	end

	def edit
		@step = Step.find(params[:id])
	end

	def update
		@step = Step.find(params[:id])
    @url = get_image_url
    p params
    respond_to do |format|
	    if @step.update_attributes(step_params)
	      format.html { redirect_to root_path, notice: 'User was successfully created.' }
	      format.js   {}
	      format.json { render json: @step, status: :created, location: @user }
	    else
	      format.html { redirect_to root_path, notice: 'dont create' }
	      format.json { render json: @step.errors, status: :unprocessable_entity }
	    end
	  end
	end

	def destroy
		p params
		@step = Step.find(params[:id])
		if @step.destroy
			p 'destroy'
		else
			p 'alert'
		end
		p @step
	end

	private

	def step_params
		params.require(:step).permit(:title, :image, :description, :number)
	end

	def get_image_url
		url = params[:step][:image]
		url = "http://res.cloudinary.com/bntu/#{url.gsub(/\#(.*)/, "")}"
	end

	def correct_instruction
		params[:format] || @instruction.id 
	end

end
																																			