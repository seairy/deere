class Property < ApplicationRecord
  include Fakeable
  extend Enumerize
  attribute :before_property_id, :integer
  enumerize :type, in: %w(string text integer float decimal date time datetime boolean array special), predicates: { prefix: true }, scope: true
  belongs_to :model
  has_one :common_validation, dependent: :destroy
  has_one :acceptance_validation, dependent: :destroy
  has_one :confirmation_validation, dependent: :destroy
  has_one :exclusion_validation, dependent: :destroy
  has_one :format_validation, dependent: :destroy
  has_one :inclusion_validation, dependent: :destroy
  has_one :length_validation, dependent: :destroy
  has_one :numericality_validation, dependent: :destroy
  has_one :presence_validation, dependent: :destroy
  has_one :absence_validation, dependent: :destroy
  has_one :uniqueness_validation, dependent: :destroy
  has_many :form_elements, dependent: :restrict_with_exception
  has_many :table_elements, dependent: :restrict_with_exception
  accepts_nested_attributes_for :common_validation
  before_create :set_position
  scope :sorted, -> { order(:position) }
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }, code: true
  validates :localized_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
  validates :sculpture, inclusion: { in: [true, false] }
  validates :common_validation, presence: true

  def self.sort sequence
    sequence.split(',').each_with_index do |id, index|
      position = index + 1
      find(id).update!(position: position)
    end
  end

  def any_validation?
    acceptance_validation.present? or confirmation_validation.present? or exclusion_validation.present? or format_validation.present? or inclusion_validation.present? or length_validation.present? or numericality_validation.present? or presence_validation.present? or absence_validation.present? or uniqueness_validation.present?
  end

  def required?
    !!(presence_validation.present? or inclusion_validation.try(:values).try(:==, ["true", "false"]))
  end

  protected
    def set_position
      model.properties.find_by(id: before_property_id).tap do |before_property|
        if before_property.present?
          self.position = before_property.position
          model.properties.where('position >= ?', before_property.position).update_all('position = position + 1')
        else
          self.position = model.properties.maximum(:position).try(:+, 1) || 1
        end
      end
    end
end
