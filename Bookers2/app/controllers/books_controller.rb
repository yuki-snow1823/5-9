class BooksController < ApplicationController
  def new
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 保存の前に、ユーザーのIDと関連してますよという記述をしてあげることで連動する！セーブの直前の行に書く
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id]) 
    @books = Book.all
    # Aさんの全部の本という記述にしたい。自分の投稿一覧の章を見直す
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
    #データベースからとってくる
  end

end