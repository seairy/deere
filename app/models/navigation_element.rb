class NavigationElement < ApplicationRecord
  belongs_to :navigation
  belongs_to :navigable, polymorphic: true
  before_create :set_position
  validates :navigation, presence: true
  validates :navigable, presence: true
  validates :navigable_id, uniqueness: { scope: %i(navigation navigable_type) }
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :navigation }

  protected
    def set_position
      self.position = navigation.elements.maximum(:position).try(:+, 1) || 1
    end
end
