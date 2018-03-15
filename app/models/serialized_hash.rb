class SerializedHash < ApplicationRecord
  belongs_to :hash_property
  validates :code, presence: true, length: { maximum: 50 }, uniqueness: { scope: :hash_property }, code: true
end
