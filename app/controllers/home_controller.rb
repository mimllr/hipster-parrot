class HomeController < ApplicationController
  def index
    if current_user
      @post = Post.new
    else
      flash[:alert] = "You must be logged in first."
      redirect_to login_path
    end
  end
end