class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.build(comment_params)
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to @comment.commentable
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :author_id, :commentable_id, :commentable_type)
  end
end
