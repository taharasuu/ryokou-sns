class Public::GosController < ApplicationController


  def index
    customer = Customer.find(params[:id])
    @posts = customer.posts
    gos = Go.where(customer_id: current_customer.id).pluck(:post_id)
    @go_list = Post.find(gos)
  end

  def create
    @post = Post.find(params[:id])
    Go.create(customer_id: current_customer.id, post_id: params[:id])
    redirect_back(fallback_location: public_post_path(@post.id))
  end

  def destroy
    @post = Post.find(params[:id])
    go = Go.find_by(customer_id: current_customer.id, post_id: params[:id])
    go.destroy
    redirect_back(fallback_location: public_post_path(@post.id))
  end

end
