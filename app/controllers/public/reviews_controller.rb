class Public::ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    redirect_to map_path(@review.map.id)
  end
  
  private

  def review_params
    params.require(:review).permit(:user_id, :map_id, :review_image, :review)
  end
  
end
