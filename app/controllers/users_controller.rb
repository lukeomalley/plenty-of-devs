# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def matches
    @user = current_user
  end

  def photo_upload
    current_user.avatar.attach(params[:avatar])
    redirect_to user_path(current_user)
  end
end
