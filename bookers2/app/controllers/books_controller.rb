class BooksController < ApplicationController
  
  def new
  end
  
  def index
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new
  end
  
  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    if book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(book.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      @book = book
      render :index
    end
  end
  
  def show
    @aBook = Book.find(params[:id])
    @book = Book.new
    @user = @aBook.user
    @comment = BookComment.new
    
  end  
  
  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
    
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(book.id)
    else
      @book = book
      render :edit
    end
  end
  
  def destroy
    flash[:notice] = "Book was successfully created."
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  
end
