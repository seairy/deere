class EnumerationElement < ApplicationRecord
  belongs_to :enumeration_property
  before_create :set_position
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :enumeration_property }, code: true
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :enumeration_property }

  def self.sort sequence
    sequence.split(',').each_with_index do |id, index|
      position = index + 1
      find(id).update!(position: position)
    end
  end

  protected
    def set_position
      self.position = enumeration_property.elements.maximum(:position).try(:+, 1) || 1
    end
end
