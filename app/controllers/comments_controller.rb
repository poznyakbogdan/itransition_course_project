class CommentsController < ApplicationController
  def new
  end

  def index
  end

  def create
  	@step = Step.find(params[:step_id])
  	user_id = params[:user_id]
  	@step.comments.create(content: params[:comment][:content], user_id: user_id)
  	p Comment.last
  	redirect_to instruction_path params[:instruction_id]
  end

  def destroy
  end

  private

  def comment_params
  	require(:comment).permit(:content)
  end

end
