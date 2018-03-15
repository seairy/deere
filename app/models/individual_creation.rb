class IndividualCreation < ApplicationRecord
  belongs_to :controller
  has_one :new_page, as: :renderable, dependent: :destroy
  has_one :confirm_page, as: :renderable, dependent: :destroy
end
