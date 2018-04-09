class RetrieveElement < ApplicationRecord
  include Presentable
  extend Enumerize
  enumerize :type, in: %w(regular), predicates: { prefix: true }, scope: true
  belongs_to :resourceful_controller
  has_many :forms, as: :formable
  has_many :tables, as: :listable
  after_create :set_form

  protected
    def set_form
      forms.create!(model: model)
    end
end
