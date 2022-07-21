class LoginsController < ApplicationController
  
  def new
    @user = User.create
  end

  def create
    @user = User.find_by(login_params)
    if @user
      session[:current_user] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Invalid credentials"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path, status: :see_other
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
  
end
