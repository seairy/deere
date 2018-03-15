class ResourcefulController < ApplicationRecord
  belongs_to :namespace
  belongs_to :model
  has_one :retrieve_element
  has_one :individual_creation
  has_one :individual_deletion
  has_many :retrieve_collections
  has_many :individual_updations
  has_many :bulk_deletions
  has_many :bulk_creations
  has_many :bulk_updations
  validates :model, uniqueness: { scope: :namespace }
end
