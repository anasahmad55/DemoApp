class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update,:destroy]
  before_action :require_same_user, only: [:update,:edit,:destroy]

  def new
    @user = User.new
  end

  def set_user
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}, You are successfully sign up"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:notice] = "#{@user.username} updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if currentUser == @user
    flash[:alert] = 'Account and articles deleted permanently'
    redirect_to root_path
  end

  private

  def require_same_user
    if currentUser != @user && !currentUser.admin?
      flash[:alert] = 'You must be same user to perform this action '
      redirect_to root_path
    end
  end
end
