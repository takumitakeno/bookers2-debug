class UsersController < ApplicationController
	before_action :authenticate_user!
  # only: [:update,]

  def show
  	@user = User.find(params[:id])
    @latlng = Geocoder.search(@user.address_city).first.coordinates
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
     if current_user.id != @user.id
      redirect_to user_path(current_user)
     end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to users_path(@user), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end
  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_following'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_code, :address_city, :address_street)
  end

  #url直接防止メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

end
