class ViewElement < ApplicationRecord
  belongs_to :view_logic
  before_create :set_position

  protected
    def set_position
      self.position = view_logic.elements.maximum(:position).try(:+, 1) || 1
    end
end
