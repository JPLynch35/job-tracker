class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.job_id = params[:job_id]
    @comment.save
    redirect_to job_path(params[:job_id])
  end

  def destroy
    @comment = Comment.includes(:job).find(params[:id])
    @job = @comment.job
    @comment.destroy

    flash[:success] = "Comment was successfully deleted!"
    redirect_to job_path(@job)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
