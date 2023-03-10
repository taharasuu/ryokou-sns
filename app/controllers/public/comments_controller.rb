class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.customer_id = current_customer.id
    if @comment.save
      redirect_to request.referer
    else
      redirect_to new_post_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end





