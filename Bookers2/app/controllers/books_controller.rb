class BooksController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update]


  def new
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 保存の前に、ユーザーのIDと関連してますよという記述をしてあげることで連動する！セーブの直前の行に書く
    @book.save

    if @book.update(book_params)
     flash[:success] = "Book was successfully created."
     redirect_to book_path(@book.id)
   else
    @books = Book.all
    @user = current_user
    render action: :index
    # indexのアクションを無視してインデックスに行く（再定義した理由）／renderの上に書くこと/newもコピペするとミスデータが上書きされる
    end

  end

  def index
    @user = current_user
    # この考えめっちゃ大事
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id]) 
    # このままだと@bookに前のデータが入ってしまう
    @books = Book.all
    # Aさんの全部の本という記述にしたい。自分の投稿一覧の章を見直す

    @user = @book.user
    # 本の投稿者が誰か
    @booknew = Book.new
  end

  def edit
    @book = Book.find(params[:id]) 
    # 仮で入力
    render layout: false #application.html.erbを適用したくない

    # @book = Book.find(params[:id])
    # データは入っているからいらない
  end

  def update
    @book = Book.find(params[:id])
    # @book.update(book_params)

  if @book.update(book_params)
    flash[:success] = "Book was successfully updated."
    redirect_to book_path(@book.id)
  else
    render action: :edit
    # updateにはviewがなく,editに書かずここに書いて良い
  end
    # 何しているか
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

  def correct_user
    @book = Book.find(params[:id])
    # まず本を取り出した 重要
    @user = @book.user
    # 本に結びついたユーザーを取り出す
    if current_user != @user
      redirect_to books_path
    end
  end

end