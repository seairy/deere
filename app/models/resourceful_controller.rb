class ResourcefulController < ApplicationRecord
  belongs_to :namespace
  belongs_to :model
  has_one :retrieve_element, dependent: :destroy
  has_one :individual_creation, dependent: :destroy
  has_one :individual_deletion, dependent: :destroy
  has_many :retrieve_collections, dependent: :destroy
  has_many :individual_updations, dependent: :destroy
  has_many :state_transitions, dependent: :destroy
  has_many :bulk_deletions, dependent: :destroy
  has_many :bulk_creations, dependent: :destroy
  has_many :bulk_updations, dependent: :destroy
  validates :model, uniqueness: { scope: :namespace }

  def human
    "#{namespace.module.camelize}##{model.code.camelize}"
  end
end
