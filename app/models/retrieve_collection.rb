class RetrieveCollection < ApplicationRecord
  include Presentable
  extend Enumerize
  enumerize :type, in: %w(regular checkable wrappable), predicates: { prefix: true }, scope: true
  belongs_to :resourceful_controller
  has_one :table, as: :listable
  has_many :navigation_elements, as: :navigable
  after_create :set_table
  validates :action_code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :resourceful_controller }

  protected
    def set_table
      create_table!(model: model)
    end
end
