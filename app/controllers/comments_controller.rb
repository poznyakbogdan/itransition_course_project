class CommentsController < ApplicationController
  
  begin
    p "12312312"
  rescue ActiveRecord::RecordInvalid => invalid
    puts invalid.record.errors
  end

  def new
  end

  def index
  end

  def create
  	@step = Step.find(params[:step_id])
  	user_id = params[:user_id]
  	if @step.comments.create!(content: params[:comment][:content], user_id: user_id)
      @comment = @step.comments.create(content: params[:comment][:content], user_id: user_id)  
    else
      p "else"
      respond_to do |format|
        p "format"  
        format.js { "alert('123213')" }
      end
    end
  end

  def destroy
  end

  private

  def comment_params
  	require(:comment).permit(:content)
  end

end
