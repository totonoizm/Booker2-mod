class BookCommentsController < ApplicationController
 before_action :authenticate_user!


  def create
		@book = Book.find(params[:book_id])
		@book_comment = @book.book_comments.build(book_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.user_id = current_user.id
		@book_comment.save
		render 'books/show'
  end

  def destroy
  	BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
		render 'books/show'

  end

  	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end

end
