class Navigation < ApplicationRecord
  belongs_to :namespace
  has_many :elements, class_name: "NavigationElement", dependent: :destroy
  before_create :set_position
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :namespace }

  protected
    def set_position
      self.position = namespace.navigations.maximum(:position).try(:+, 1) || 1
    end
end
