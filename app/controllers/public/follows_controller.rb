class Public::FollowsController < ApplicationController

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followed
    @customer = Customer.find(params[:id])
    @followeds = @customer.followeds
  end
  # フォロワー一覧
  def follower
    @customer = Customer.find(params[:id])
    @followers = @customer.followers
  end


  def follow_params
    params.require(:follow).permit(:followed_id, :follower_id)
  end

end
