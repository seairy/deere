class UniquenessValidation < ApplicationRecord
  include Iconize
  serialize :scopes, Array
  belongs_to :property

  def summary
    "scopes: [#{scopes.join(', ')}]" if scopes.present?
  end
end
