class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params.require(:category).permit(:name))
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end
end
