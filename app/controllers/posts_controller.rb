class PostsController < ApplicationController

  before_action :set_post,  only: %i[show edit update]

  def index
    user = User.find_by(id: session[:current_user])
    if user.blank?
      flash[:notice] = "Welcome dear guest"
    else
      flash[:notice] = "Welcome #{user.name}"
    end
    @posts = Post.all.order(created_at: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:current_user]
    if @post.save
      flash[:alert] = "Post successfully created"
      redirect_to root_path
    else
      flash[:alert] = "Can't create this post : " + @post.errors.full_messages.to_s
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    if @post.user_id != session[:current_user]
      flash[:alert] = "You may not update this post"
      redirect_to root_path
    end
  end

  def update

    if @post.user_id != session[:current_user]
      flash[:alert] = "Operation not allowed"
      redirect_to root_path and return
    end 

    if @post.update(post_params)
      flash[:alert] = "Post successfully updated"
      redirect_to root_path
    else
      flash[:alert] = "Can't update this post : " + @post.errors.full_messages.to_s
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
