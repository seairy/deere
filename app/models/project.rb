class Project < ApplicationRecord
  has_many :models, dependent: :restrict_with_exception
  has_many :namespaces, dependent: :restrict_with_exception
  has_many :resourceful_controllers, through: :namespaces
  has_many :source_codes, dependent: :destroy
  has_one :route_file, dependent: :destroy
  validates :code, presence: true, length: { maximum: 100 }, code: true

  def compile
    source_codes.destroy_all
    ModelsEngine.new(self).compile
    MigrationsEngine.new(self).compile
  end
end
