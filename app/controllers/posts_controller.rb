class PostsController < ApplicationController

  before_action :set_post, :except => [:index, :new]
  
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

  private

  def post_params
    params.require(:post).permit(:title, :body).merge(user_id: session[:current_user])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
