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
		# Step.update(steps.keys, steps.values)																										
		p params
		Step.transaction do
			steps.each do |key, value|
				Step.connection.update("UPDATE steps SET number='#{value[:number]}' WHERE id=#{key}")
			end
		redirect_to instruction_path params[:format]
		end
		# redirect_to instruction_path 
	end																										

	def create
		instruction_id = params[:instruction_id]
		@step = Step.new step_params
		@step.instruction_id = instruction_id
		if @step.save
			
		else
			render 'index'
		end
	end

	private

	def step_params
		params.require(:step).permit(:title, :image, :description, :number)
	end
end
																																			