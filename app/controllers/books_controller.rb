class BooksController < ApplicationController
  
  before_action :current_user, only: [ :edit, :update]
    
  def new
    @book = Book.new
  end
  
  def index
    @books = Book.all
    @user = current_user
    @book=Book.new
  end

  def create
    @book = Book.new(book_params)
     @book.user_id = current_user.id
  if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
  else
     @books = Book.all
     @user = current_user
     render :index
     #redirect_to books_path
  end
  
  end
  

  
  def show
    @book = Book.find(params[:id])
    @user = current_user
  end
  
  def edit
    @book = Book.find(params[:id])
    @book = Book.new
    
  end
  
  def update
    book = Book.find(params[:id])
     
     if book.update(book_params)
       flash[:notice] = "You have updated book successfully.."
       redirect_to book_path(book.id)
     else
        @books = Book.all
        render :edit
     end
  end
  
 def destroy
   
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
 end
  
  private
  # ストロングパラメータ
  def book_params #title body user_idをデータベースに保存する許可
    params.require(:book).permit(:title, :body, :user_id)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
