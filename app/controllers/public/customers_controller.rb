class Public::CustomersController < ApplicationController

#投稿検索機能
  def search
    if params[:keyword].present?
      @customers = Customer.search(params[:keyword])
    else
      @customers = []
    end
    @keyword = params[:keyword]
  end


  def new
    @customer = Customer.new
  end

  def create
    customer = Customer.new(customer_params)
    customer.save
    redirect_to about_path
  end

  def show
    @customer = Customer.find(params[:id])
    @customers = Customer.all
    @posts = current_customer.posts.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to public_customer_path(current_customer.id)
  end

  private

    def customer_params
      params.require(:customer).permit(:user_name, :introduction, :image)
    end

end
