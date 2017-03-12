class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private
  	def set_instruction
			# @instruction = current_user.instructions.find(params[:id])
			@instruction = current_user.instructions.eager_load(:steps, :tags).where(id: params[:id]).to_a.first
		end
 
	def set_locale
	  I18n.locale = params[:locale] || I18n.default_locale
	end

	def default_url_options(options = {}) 
		{locale: I18n.locale}
	end

end
