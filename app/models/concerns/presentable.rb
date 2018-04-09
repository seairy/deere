module Presentable
  extend ActiveSupport::Concern

  included do
    belongs_to :model
    before_create :set_model
  end

  protected
    def set_model
      self.model = self.resourceful_controller.model
    end
end
