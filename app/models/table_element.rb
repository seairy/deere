class TableElement < ApplicationRecord
  belongs_to :table
  belongs_to :property
  has_one :formatter, as: :formattable, dependent: :destroy
  has_one :string_formatter, as: :formattable
  has_one :number_formatter, as: :formattable
  has_one :boolean_formatter, as: :formattable
  has_one :datetime_formatter, as: :formattable
  before_create :set_position
  scope :sorted, -> { order(:position) }
  validates :property, presence: true, uniqueness: { scope: :table }

  def self.sort sequence
    sequence.split(',').each_with_index do |id, index|
      position = index + 1
      find(id).update!(position: position)
    end
  end

  protected
    def set_position
      self.position = table.elements.maximum(:position).try(:+, 1) || 1
    end
end
