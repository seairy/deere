module Iconize
  extend ActiveSupport::Concern

  class_methods do
    def icon
      case self.to_s
      when 'AcceptanceValidation' then 'icon-select2'
      when 'ConfirmationValidation' then 'icon-spell-check'
      when 'ExclusionValidation' then 'icon-upload2'
      when 'FormatValidation' then 'icon-text-format'
      when 'InclusionValidation' then 'icon-download2'
      when 'LengthValidation' then 'icon-rulers'
      when 'NumericalityValidation' then 'icon-sort-numeric-asc'
      when 'PresenceValidation' then 'icon-archive'
      when 'AbsenceValidation' then 'icon-inbox'
      when 'UniquenessValidation' then 'icon-key'
      end
    end
  end
end
