class PostsController < ApplicationController
  def new
    if current_user
      @post = Post.new
    else
      flash[:alert] = "You must be logged in first."
      redirect_to login_path
    end
  end

  def create
    @post = Post.new(post_params)
    current_user.posts << @post
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.delete
      flash[:notice] = "Post was successfully deleted."
      redirect_to :back
    else
      flash[:alert] = "Post could not be deleted."
      redirect_to :back
    end
  end

  def deck
    @posts = Post.all
  end

    private

  def post_params
    params.require(:post).permit(:text)
  end

end