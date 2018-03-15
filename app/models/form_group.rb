class FormGroup < ApplicationRecord
  extend Enumerize
  belongs_to :form
  belongs_to :property
  before_create :set_position
  validates :property, uniqueness: { scope: :form }

  protected
    def set_position
      self.position = form.groups.maximum(:position).try(:+, 1) || 1
    end
end
