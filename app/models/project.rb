class Project < ApplicationRecord
  extend Enumerize
  enumerize :primary_language, in: %w(en zh_CN), predicates: { prefix: true }, scope: true
  has_many :models, dependent: :restrict_with_exception
  has_many :namespaces, dependent: :restrict_with_exception
  has_many :resourceful_controllers, through: :namespaces
  has_many :source_codes, dependent: :destroy
  has_one :route_file, dependent: :destroy
  validates :code, presence: true, length: { maximum: 100 }, code: true

  def compile
    source_codes.destroy_all
    ControllersEngine.new(self).compile
    I18nEngine.new(self).compile
    MigrationsEngine.new(self).compile
    ModelsEngine.new(self).compile
    RoutesEngine.new(self).compile
    ViewsEngine.new(self).compile
  end
end
