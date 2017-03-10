class UsersController < ApplicationController
	def show
		# @user = User.eager_load(:instructions).where(id: params[:id]).to_a.first
		@user = User.find(params[:id])
		@instructions = Instruction.where(user_id: params[:id]).eager_load(:category, :tags).to_a
		@have_access = get_access
	end

	private
		def get_access
			# Instruction.accessible_by(current_ability).count == Instruction.count
			# Instruction.accessible_by(current_ability, :update)
		end
end
