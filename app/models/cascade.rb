class Cascade < ApplicationRecord
  extend Enumerize
  belongs_to :source, class_name: 'Model'
  belongs_to :destination, class_name: 'Model'
  has_many :redundancies, class_name: 'CascadeRedundancy'
  enumerize :type, in: %w(has_one has_many has_many_and_belongs_to), predicates: { prefix: true }, scope: true
  validates :source_alias_name, length: { maximum: 100 }, allow_blank: true
  validates :destination_alias_name, length: { maximum: 100 }, allow_blank: true
end
