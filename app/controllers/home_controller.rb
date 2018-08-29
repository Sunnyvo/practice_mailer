class HomeController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.paginate(per_page: "10", page: params[:page])
  end
end
