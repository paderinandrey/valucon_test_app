class Photo < ApplicationRecord
  dragonfly_accessor :image do
    after_assign do |img|
      img.thumb!('100x100#') if img.image?
    end
  end

  validates :image, presence: true
  validates_size_of :image, maximum: 500.kilobytes,
                     message: 'should be no more than 500 KB', if: :image_changed?
end
