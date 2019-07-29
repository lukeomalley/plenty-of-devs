class MatchesController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.select do |user|
      user.id != current_user.id && !current_user.liked_users.include?(user) && current_user.matches.where(is_denied: true).include?(user)
    end
  end

  def liked
    @liked_user = User.find(params[:liked_user])
    @user = current_user
    if Match.all.find_by(liked_user_id: @user.id)
      match = Match.all.find_by(liked_user_id: @user.id)
      match.update(is_matched: true)
    else
      Match.create(user_id: @user.id, liked_user_id: @liked_user.id)
    end
    redirect_to root_path
  end

  def disliked
    @disliked_user = User.find(params[:disliked_user])
    @user = current_user
    if Match.all.find_by(liked_user_id: @user.id)
      match = Match.all.find_by(liked_user_id: @user.id)
      match.update(is_matched: false, is_denied: true)
    else
      Match.create(user_id: @user.id, liked_user_id: @disliked_user.id, is_denied: true)
    end
    redirect_to root_path
  end
end
