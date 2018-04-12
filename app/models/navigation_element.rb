class NavigationElement < ApplicationRecord
  belongs_to :navigation
  belongs_to :navigable, polymorphic: true
  before_create :set_position

  protected
    def set_position
      self.position = namespace.elements.maximum(:position).try(:+, 1) || 1
    end
end
