# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :user
  belongs_to :liked_user, class_name: 'User'
  has_one :chat
end
