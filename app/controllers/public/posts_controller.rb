class Public::PostsController < ApplicationController

  before_action :authenticate_customer!, except: :index

#投稿検索機能
  def search
    if params[:keyword].present?
      @posts = Post.search(params[:keyword])
    else
      @posts = []
    end
    @keyword = params[:keyword]
  end


  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.customer_id = current_customer.id
    post.save
    redirect_to public_post_path(post.id)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
    @comments = @post.comments
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to public_post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:shop, :postal_code, :address, :evaluation, :text, :image)
  end
end
