class PostsController < ApplicationController
  
  def index
    user = User.find_by(id: session[:current_user])
    if user.blank?
      flash[:notice] = "Welcome dear guest"
    else
      flash[:notice] = "Welcome #{user.name}"
    end
  end

end
