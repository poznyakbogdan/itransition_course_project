class UsersController < ApplicationController
	def show
		@user = User.eager_load(:instructions).where(id: params[:id]).to_a.first
	end
end
