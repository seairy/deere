class ImageUploader < ApplicationRecord
  extend Enumerize
  belongs_to :file_property
  enumerize :resize_method, in: %w(fill fit), predicates: { prefix: true }, scope: true
  validates :quality, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, only_integer: true }
  validates :resize_method, presence: true, inclusion: { in: ImageUploader.resize_method.values }
  validates :width, presence: true, numericality: { greater_than: 0, less_than: 10000, only_integer: true }
  validates :height, presence: true, numericality: { greater_than: 0, less_than: 10000, only_integer: true }
end
