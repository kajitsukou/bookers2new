class BooksController < ApplicationController
before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id),notice: 'Book was successfully created.'
    else
      @user = current_user
      @books = Book.all
      render :index
      flash[:notice] = 'error'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
    redirect_to books_path
    end
  end

def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice: 'Book was successfully updated.'
    else
      render :edit
      flash[:notice] = 'error'
    end
  end

def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end