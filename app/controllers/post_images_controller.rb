class PostImagesController < ApplicationController
  def new
   @post_image = PostImage.new
  end
  
  def create
   @post_image = PostImage.new(post_image_params)
# @post_image は、PostImage.new によって生成された、PostImage の空のモデル
   @post_image.user_id = current_user.id
# 空のモデルでは、PostImage モデルで定義したカラムを@post_image.user_idのように、
# "[モデル名].[カラム名]"という形で繋げることで、保存するカラムの中身を操作することができます
# current_user は、ログイン中のユーザー情報を取得することができるため、current_user.id と記述することで
# ログインユーザーの id を取得することができる
# つまり→@post_image(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーの ID)に
# 指定することで投稿データに、今ログイン中のユーザーの ID を持たせることができる。
   if @post_image.save
    redirect_to post_images_path
   else
   render :new
   end
  end

  def index
    @post_images = PostImage.page(params[:page])
    
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end
    
  
  private

  def post_image_params
   params.require(:post_image).permit(:shop_name, :image, :caption)
  end
  
end
