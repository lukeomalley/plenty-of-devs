class MatchesController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = current_user.filter_users
  end

  def liked
    @liked_user = User.find(params[:liked_user])
    @user = current_user
    if Match.all.find_by(user: @liked_user, liked_user: @user)
      match = Match.all.find_by(user: @liked_user, liked_user: @user)
      match.update(is_matched: true)
    else
      Match.create(user_id: @user.id, liked_user_id: @liked_user.id)
    end
    redirect_to root_path
  end

  def disliked
    @disliked_user = User.find(params[:disliked_user])
    @user = current_user
    if Match.all.find_by(user: @disliked_user, liked_user: @user)
      match = Match.all.find_by(user: @disliked_user, liked_user: @user)
      match.update(is_denied: true)
    else
      Match.create(user_id: @user.id, liked_user_id: @disliked_user.id, is_denied: true)
    end
    redirect_to root_path
  end
end
