class PostCommentsController < ApplicationController
  
  def create
    post_image = PostImage.find(params[:post_image_id])
    comment = current_user.post_comments.new(post_comment_params)
    # 上記記述は下記の記述と同じ
    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    # comment.user_id,つまりこのコメントの user_id としてcurrent_user.id の値を代入する
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)
  end
  
  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_image_path(params[:post_image_id])
  end
  
  
  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
