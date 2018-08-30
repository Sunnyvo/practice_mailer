class HomeController < ApplicationController
  def index
    @comment =Comment.new
    @post = Post.new
    @posts = Post.paginate(per_page: "5", page: params[:page])
  end
end
