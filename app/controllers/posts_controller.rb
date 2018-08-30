class PostsController < ApplicationController
  def index
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
