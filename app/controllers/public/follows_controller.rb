class Public::FollowsController < ApplicationController

  def create
    current_customer.followed(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followed
    @customer = Customer.find(params[:id])
    @followeds = @customer.followeds.page(params[:page]).per(6)
  end
  # フォロワー一覧
  def follower
    @customer = Customer.find(params[:id])
    @followers = @customer.followers.page(params[:page]).per(6)
  end


  def follow_params
    params.require(:follow).permit(:followed_id, :follower_id)
  end

end
