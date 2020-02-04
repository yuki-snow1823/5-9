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
    @user = current_user
    # この考えめっちゃ大事
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id]) 
    @books = Book.all
    # Aさんの全部の本という記述にしたい。自分の投稿一覧の章を見直す

    @user = @book.user
    # 本の投稿者が誰か
    @booknew = Book.new
  end

  def edit
    @book = Book.find(params[:id]) 
    # 仮で入力
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    # 何しているか
    redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  # 一覧画面へリダイレクトしたい
  # 文字の表示をインデックスでリダイレクトした後に行いたい 
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
    #データベースからとってくる
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end