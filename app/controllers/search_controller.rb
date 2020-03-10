class SearchController < ApplicationController
	def search
		@select = params["select"]
		@search = params["search"]
		@kind = params["kind"]
		@records= searching(@select, @search, @kind)
	end

	private
	# SQLが読み取れるようにかく。likeは小文字で書く。半角でスペースあけて？にする。カンマも忘れずに。
	def searching(select,search, kind)
      if select == "user"
		if kind == "match"
		   User.where("name like ?", "#{search}")
		elsif kind == "forward"
		   User.where("name like ?", "#{search}%")
		elsif kind = "backward"
           User.where("name like ?", "%#{search}")
        elsif kind == "partical"
           User.where("name like ?", "%#{search}%")
        end
	  elsif select == "book"
		if kind == "match"
		   Book.where("title like ?", "#{search}")
		elsif kind =="forward"
		   Book.where("title like ?", "#{search}%")
        elsif kind == "backward"
           Book.where("title like ?", "%#{search}")
        elsif kind == "partical"
           Book.where("title like ?", "%#{search}%")
        end
      end
	end
end
