class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :schedule
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  validates :title, length: { in: (1..40)}
  validates :description, length: { in: (1..1000)}
  validates :price, inclusion: { in: (300..9999999)}
  with_options presence: true do
    validates :condition
    validates :postage
    validates :prefecture
    validates :schedule
    validates :user_id
    validates :category_id
  end
end
