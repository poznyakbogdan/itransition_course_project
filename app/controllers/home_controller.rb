class HomeController < ApplicationController
  def index
  	@instruction = Instruction.order(:cached_votes_score => :desc).limit(1).eager_load(:category, :user, :tags, :steps).to_a.first
  	@comments = Comment.where(step_id: @instruction.steps.ids).eager_load(:user).to_a
  end
end
