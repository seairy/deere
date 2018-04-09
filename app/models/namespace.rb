class Namespace < ApplicationRecord
  extend Enumerize
  enumerize :theme, in: %w(boooya_default boooya_header_custom), predicates: { prefix: true }, scope: true
  belongs_to :project
  has_many :resourceful_controllers, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
  validates :module, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
  validates :path, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
end
