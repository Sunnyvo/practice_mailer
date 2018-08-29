class LikesController < ApplicationController
  def toggle
    if params[:post_id]
      @item = Post.find params[:post_id]
     elsif params[:comment_id]
      @item = Comment.find(params[:comment_id])
    end
    current_user.toggle_like!(@item)

    respond_to do |f|
      f.html{ redirect_back(fallback_location: root_path) }
      f.js { render 'toggle' }
    end
  end
end
