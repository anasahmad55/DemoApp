class ArticlesController < ApplicationController
  before_action :set_article, only: [:show , :update, :edit, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:update,:edit, :destroy]

  def show; end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(param)
    @article.user = currentUser
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

  def require_same_user
    if currentUser != @article.user
      flash[:notice] = 'You must be same user to perform this action '
      redirect_to articles_path
    end
  end
end
