class PostsController < ApplicationController
  def index
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      if params[:post_attachments]
        params[:post_attachments][:photo].each do |a|
          @post_attachment = @post.post_attachments.create!(photo: a)
        end
      end
      current_user.reaches.create post: @post
      respond_to do |f|
        f.html{ redirect_back(fallback_location: root_path) }
        f.js { render 'post' }
      end

    else
      flash[:error] = "Error: #{@post.errors.full_messages.to_sentence}"
      # format.html { redirect_to @post, notice: 'post was successfully created.' }
      # format.json { render :show, status: :created, location: @post }
      # format.html { render :new }
      # format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
