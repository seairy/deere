class EnumerationElement < ApplicationRecord
  belongs_to :enumeration_property
  before_create :set_position
  validates :name, presence: true, length: { maximum: 50 }
  validates :zh_name, presence: true, length: { maximum: 50 }
  validates :en_name, presence: true, length: { maximum: 50 }

  protected
    def set_position
      self.position = enumeration_property.elements.maximum(:position) || 1
    end
end
