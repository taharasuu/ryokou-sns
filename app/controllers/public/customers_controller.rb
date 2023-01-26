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
 #会員情報変更
  def inf_edit
    @customer = Customer.find(params[:customer_id])
  end

  def inf_update
    customer = Customer.find(params[:customer_id])
    customer.update(customer_params)
    redirect_to public_customer_path(current_customer.id)
  end
#ゲストログイン機能
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.confirmed_at = Time.now # ← Confirmable を設定している場合は追加
      # user.name = "ゲストユーザー" # ←ユーザー名を設定している場合は追加
    end
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
    @posts = current_customer.posts.page(params[:page]).per(8)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to public_customer_path(current_customer.id)
  end

  #退会機能
  def confirm

  end

  def withdrow
    customer = current_customer
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

    def customer_params
      params.require(:customer).permit(:user_name, :introduction, :image)
    end

end
