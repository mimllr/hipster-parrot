class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Hipster Parrot, #{@user.username}."
      redirect_to user_path(@user)
    else
      render :new  
    end
  end

  def show
    @user = User.find_by_id(params[:id])

    if @user.posts.count > 0
      @post_count = @user.posts.count
    else
      @post_count = ""
    end

    following = @user.follow_count.to_f
    followers = @user.followers.count.to_f
    

    if followers == 0
      @ratio = "No ratio."
    else
      @ratio = (followers / following).round(2)
    end
  end

  def follow
    @user = User.find_by_id(params[:id])

    if current_user
      if current_user == @user
        flash[:alert] = "You cannot follow yourself."
      else
        current_user.follow(@user)
        redirect_to user_path(params[:id])
        flash[:notice] = "You are now following #{@user.username}."
      end
    else
      flash[:alert] = "You must <a href='/login'>login</a> to follow #{@user.username}.".html_safe
    end
  end


  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      redirect_to user_path(params[:id])
      flash[:notice] = "You are no longer following #{@user.username}."
    else
      flash[:alert] = "You must <a href='/login'>login</a> to unfollow #{@user.username}.".html_safe
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
