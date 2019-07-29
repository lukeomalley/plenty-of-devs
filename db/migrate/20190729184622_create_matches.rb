# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.belongs_to :user
      t.belongs_to :liked_user
      t.index %i[user_id liked_user_id], unique: true
      t.boolean :is_matched, default: false
      t.boolean :is_denied, default: false

      t.timestamps
    end
  end
end
