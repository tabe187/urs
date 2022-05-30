class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to map_path(@review.map.id)
  end

  def edit
    @review =Review.find(params[:id])
    if current_user != @review.user_id
      redirect_back fallback_location: root_path
    end  
  end

  def update
    @review =Review.find(params[:id])
    @review.update(review_params)
    redirect_to map_path(@review.map.id)
  end

  def destroy
    @review =Review.find(params[:id])
    @review .destroy
    redirect_to map_path(@review.map.id)
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :map_id, :review_image, :review, :rating)
  end

end
