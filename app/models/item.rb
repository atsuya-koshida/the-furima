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
end
