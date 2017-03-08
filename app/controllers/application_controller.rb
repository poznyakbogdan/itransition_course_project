class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  	def set_instruction
			# @instruction = current_user.instructions.find(params[:id])
			@instruction = current_user.instructions.eager_load(:steps, :tags).where(id: params[:id]).to_a.first
		end

end
