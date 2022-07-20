class LoginController < ApplicationController
  
  def new
    @user = User.create
  end

  def create
    @user = User.find_by(login_params)
    if @user
      redirect_to root_path
    else
      flash[:alert] = "Invalid credentials"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
  
end
