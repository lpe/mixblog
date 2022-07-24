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
    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to root_path
    else
      flash[:alert] = "Can't create this post"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to root_path
    else
      flash[:alert] = "Can't update this post"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: session[:current_user])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
