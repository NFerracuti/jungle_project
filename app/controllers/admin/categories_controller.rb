class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
  
    if @category.save
      redirect_to [:admin, :categories], notice: 'Category successfully created! :)'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category successfully updated! :)'
    else
      render :edit
    end
  end  

  def destroy
    if @category.products.any?
      redirect_to admin_categories_path, alert: 'Category cannot be deleted as it has associated products.'
    else
      @category.destroy
      redirect_to admin_categories_path, notice: 'Category successfully deleted!'
    end
  end
  
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)  # Assuming you have a 'name' attribute in the Category model.
  end
  
end
