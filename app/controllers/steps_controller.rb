class StepsController < ApplicationController

	def index
		@instruction_id = params[:instruction_id]
		p params
		 
	end

	def new
		@step = Step.new
	end

	def create
		
	end

	private

	def steps_params
		params.require(:step).permit(:title, :image, :decription, :number)
	end
end
