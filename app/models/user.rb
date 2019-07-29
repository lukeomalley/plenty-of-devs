# frozen_string_literal: true

class User < ApplicationRecord
  has_many :matches
  # all the users that I have liked
  has_many :liked_users, through: :matches

  # all the people who have liked me
  has_many :likers, foreign_key: :liked_user_id, class_name: 'Match'
  has_many :liker_users, through: :likers, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def filter_users
    User.all.select do |user|
      matches_self_created = Match.all.find_by(user: self, liked_user: user)
      matches_user_created = Match.all.find_by(user: user, liked_user: self, is_denied: true)
      case user
      when self
        # filter out self
        false
      when matches_self_created.nil? ? self : matches_self_created.liked_user
        # filter out users that you have already liked
        # filter out users that you denied
        false
      when matches_user_created.nil? ? self : matches_user_created.user
        # filter out users that denied you
        false
      else
        true
      end
    end
  end

  def users_ive_liked
    liked_users.select do |user|
      match = Match.all.find_by(user: self, liked_user: user, is_denied: true)
      case user
      when match.nil? ? self : match.liked_user
        false
      else
        true
      end
    end
  end
end
