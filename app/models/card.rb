class Card < ApplicationRecord
  belongs_to :user
  validates :card_id, :customer_id, presence: true
end
