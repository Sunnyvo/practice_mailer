class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build comment_params

    if @comment.save
      @current_post = @comment.post
    else
      # xu ly error
    end

    respond_to do |f|
      f.html{ redirect_back(fallback_location: root_path) }
      f.js { render 'comment' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
