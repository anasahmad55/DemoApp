class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 4)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category name updated successfully"
      redirect_to @category
    else
      render 'edit'
    end
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
