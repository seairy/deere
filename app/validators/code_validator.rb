class CodeValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    record.errors.add(attribute, :does_not_follow_the_naming_conventions) if false
  end
end