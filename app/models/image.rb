class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item

  before_destroy :remove_image
  private

  def remove_image
    image.remove!
  rescue Exception => e
    logger.error(e.message)
  end
end
