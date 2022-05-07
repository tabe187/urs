class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :index
    end  
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @categories = Category.all
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end    
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
