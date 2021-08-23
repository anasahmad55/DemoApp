class ArticlesController < ApplicationController
  before_action :set_article, only: [:show , :update, :edit, :destroy]

  def show; end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(param)
    if @article.save
      flash[:notice] = 'Article was created successfully.'
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(param)
      flash[:notice] = 'Article was updated successfully'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def param
    params.require(:article).permit(:title, :description)
  end

end
