class Namespace < ApplicationRecord
  extend Enumerize
  enumerize :theme, in: %w(boooya_default boooya_header_custom), predicates: { prefix: true }, scope: true
  belongs_to :project
  belongs_to :authenticator, class_name: "Model"
  has_many :resourceful_controllers, dependent: :destroy
  has_many :navigations, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
  validates :module, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
  validates :path, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
end
