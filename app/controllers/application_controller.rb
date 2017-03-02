class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  	def set_instruction
			@instruction = current_user.instructions.find(params[:id])
		end

end
