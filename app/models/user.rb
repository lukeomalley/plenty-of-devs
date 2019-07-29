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

end
