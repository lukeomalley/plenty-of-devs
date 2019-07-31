class Chat < ApplicationRecord
  belongs_to :match
  has_many :messages
  has_many :users, through: :messages
end
