class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path
  end
  
    private

  def user_params
    params.require(:user).permit(:name, :email, :region, :city, :hobby, :profile, :birthday_year, :birthday_month, :birthday_day, :gender, :is_active, :profile_image, :is_deleted)
  end
  
end
