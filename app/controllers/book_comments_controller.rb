class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@book_comment = current_user.book_comments.new(book_comment_params)
		# book_comment = BookComment.new(book_comment_params)
		# book_comment.user_id = current_user.id
		# レコードに入れる値をいれてあげているだけ
		# １対他の関係なので、モデルであっても複数形となる
		@book_comment.book_id = @book.id
		if @book_comment.save
		# binding.pry
		@book_comments = @book.book_comments
		# binding.pry
	    else
	    @booknew = Book.new
	    @user = @book.user
	    # @book_comment = BookComment.newを書いてしまうと、データが初期化されてしまう。上から順に読まれることを意識する。
	    render :"books/show"
	    end

	end
	def destroy
		# binding.pry
		@book = Book.find(params[:book_id])
		@book_comment = current_user.book_comments.find_by(id: params[:id])
		@book_comments = @book.book_comments
		@book_comment.destroy
	end
	private
    def book_comment_params
    params.require(:book_comment).permit(:comment)
    end  
end
