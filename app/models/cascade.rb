class Cascade < ApplicationRecord
  extend Enumerize
  belongs_to :source, class_name: 'Model'
  belongs_to :destination, class_name: 'Model'
  has_many :redundancies, class_name: 'CascadeRedundancy'
  enumerize :type, in: %w(has_one has_many), predicates: { prefix: true }, scope: true
  enumerize :action_when_owner_destroyed, in: %w(nothing destroy delete nullify restrict_with_exception restrict_with_error), predicates: { prefix: true }, scope: true
  enumerize :action_when_child_destroyed, in: %w(nothing destroy delete), predicates: { prefix: true }, scope: true
  validates :source_alias, length: { maximum: 100 }, format: /\A\w+\Z/, allow_blank: true, code: true
  validates :destination_alias, length: { maximum: 100 }, format: /\A\w+\Z/, allow_blank: true, code: true
  validates :action_when_owner_destroyed, presence: true
  validates :action_when_child_destroyed, presence: true
  validate :alias_must_be_provided_when_source_and_destination_are_both_exist

  protected
    def alias_must_be_provided_when_source_and_destination_are_both_exist
      errors.add(:base, :alias_must_be_provided_when_source_and_destination_are_both_exist) if Cascade.where(source: source, destination: destination).present? and (source_alias.blank? or destination_alias.blank?)
    end
end
