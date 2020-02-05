class UsersController < ApplicationController
  # ログインしているユーザーのみ・・・意図的に
  before_action :authenticate_user! 


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
    # urlをもとにユーザーをとってくる
    @book = Book.new
    @books = @user.books
    # 自分の投稿が羅列されるように(ユーザーに関連している本)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

  if @user.update(user_params)
    flash[:success] = "User was successfully updated."
    redirect_to user_path(@user.id)
  else
    render action: :edit
  end
  end
  # elseの下に入れると二重になる


  def create
  end

  private 
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
