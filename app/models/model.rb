class Model < ApplicationRecord
  serialize :includes_classes, Array
  serialize :extends_classes, Array
  belongs_to :project
  has_one :orm_loggable
  has_one :authenticatable
  has_one :sortable
  has_one :trashable
  has_one :state_machine
  has_many :properties
  has_many :regular_properties
  has_many :enumeration_properties
  has_many :file_properties
  has_many :cascades_as_source, class_name: 'Cascade', foreign_key: 'source_id'
  has_many :cascades_as_destination, class_name: 'Cascade', foreign_key: 'destination_id'
  validates :includes_classes, length: { maximum: 1000 }
  validates :extends_classes, length: { maximum: 1000 }
  validates :name, presence: true, length: { maximum: 100 }, format: /\A\w+\Z/
  validates :zh_name, presence: true, length: { maximum: 100 }
  validates :en_name, presence: true, length: { maximum: 100 }

  def cascades_ids
    [id, cascades_as_source.pluck(:destination_id), cascades_as_destination.pluck(:source_id)].flatten.compact
  end
end
