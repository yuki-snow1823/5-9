class UsersController < ApplicationController

  def index
    @user = current_user
    # この考えめっちゃ大事
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    # 自分の投稿が羅列されるように
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def create
  end

  private 
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
