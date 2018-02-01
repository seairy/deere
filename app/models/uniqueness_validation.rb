class UniquenessValidation < ApplicationRecord
  include Iconize
  serialize :scopes, Array
  belongs_to :property
end
