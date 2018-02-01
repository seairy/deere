class Property < ApplicationRecord
  extend Enumerize
  attribute :before_property_id, :integer
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
  enumerize :type, in: %w(string text integer float decimal date time datetime boolean array special), predicates: { prefix: true }, scope: true
  accepts_nested_attributes_for :common_validation
  before_create :set_position
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }, format: /\A\w+\Z/
  validates :zh_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
  validates :en_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
  validates :common_validation, presence: true


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
