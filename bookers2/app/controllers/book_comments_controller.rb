class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book.id)
  end
  
  def destroy
    comment = BookComment.find(params[:id])
    if current_user.id == comment.user.id
      comment.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
