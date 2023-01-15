class Public::GoodsController < ApplicationController

  def create
    @post = Post.find(params[:id])
    Good.create(customer_id: current_customer.id, post_id: params[:id])
    redirect_back(fallback_location: public_post_path(@post.id))
  end

  def destroy
    @post = Post.find(params[:id])
    good = Good.find_by(customer_id: current_customer.id, post_id: params[:id])
    good.destroy
    redirect_back(fallback_location: public_post_path(@post.id))
  end

end
