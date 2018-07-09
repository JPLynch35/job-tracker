class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.job_id = params[:job_id]

    @comment.save

    redirect_to job_path(params[:job_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
