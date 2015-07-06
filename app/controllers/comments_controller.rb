class CommentsController < ApplicationController
  def create
    @job = Job.find(params[:job_id])
    @comment = @job.comments.create(comment_params)

    respond_to do |format|
      format.html { redirect_to jobs_path }
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
