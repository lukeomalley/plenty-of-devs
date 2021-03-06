# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :matches
  # all the users that I have liked
  has_many :liked_users, through: :matches

  # all the people who have liked me
  has_many :likers, foreign_key: :liked_user_id, class_name: 'Match'
  has_many :liker_users, through: :likers, source: :user

  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def filter_users
    # returns a filtered list of users that no longer need to show for
    # the current logged in user on the match page
    User.all.select do |user|
      matches_self_created = Match.all.find_by(user: self, liked_user: user)
      matches_user_created = Match.all.find_by(user: user, liked_user: self, is_denied: true)
      self_matches = Match.all.find_by(user: self, liked_user: user, is_matched: true)
      user_matches = Match.all.find_by(user: user, liked_user: self, is_matched: true)

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
      when self_matches.nil? ? self : self_matches.liked_user
        false
      when user_matches.nil? ? self : user_matches.user
        false
      else
        true
      end
    end
  end

  def my_matches
    # This function returns all the matches where the user is involved
    # both matches that the user created and matches where this user was liked or denied
    (matches + Match.all.where(liked_user: self)).select do |match|
      match.is_matched == true && match.is_denied == false
    end
  end

  def my_matches_users
    # maps over array of all matches and returns the users
    my_matches.map do |match|
      match.user == self ? match.liked_user : match.user
    end
  end

  def find_match(user)
    Match.find_by(user: self, liked_user: user).nil? ? Match.find_by(user: user, liked_user: self) : Match.find_by(user: self, liked_user: user)
  end

  def featured_project(featured_project)
    selected_project = Project.find(featured_project)
    self.projects.each do |project|
        project.update(is_featured: false) 
    end
    selected_project.update(is_featured: true)
end
  
end
