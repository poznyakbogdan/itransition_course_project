class UsersController < ApplicationController
	def show
		# @user = User.eager_load(:instructions).where(id: params[:id]).to_a.first
		@user = User.find(params[:id])
		@instructions = Instruction.where(user_id: params[:id]).eager_load(:category, :tags).to_a
	end
end
