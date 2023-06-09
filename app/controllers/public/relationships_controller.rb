class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  
  # フォロー一覧
  def followings
    @users = current_user.followings.page(params[:page])
  end
  # フォロワー一覧
  def followers
    @users = current_user.followers.page(params[:page])
  end
  
end
