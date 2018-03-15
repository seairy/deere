class ViewLogic < ApplicationRecord
  belongs_to :namespace
  belongs_to :model
  has_many :elements, class_name: 'ViewElement', dependent: :destroy
  has_many :tables, foreign_key: 'view_logic_id', dependent: :destroy
  has_many :forms, foreign_key: 'view_logic_id', dependent: :destroy
  validates :type, presence: true

  protected
    def base_restriction_of_elements rules
      rules[type].map do |restriction_rule|
        { class_name: restriction_rule[:class_name],
          maximum_count: restriction_rule[:maximum_count],
          remaining_count: (case restriction_rule[:maximum_count]
                            when '*' then :no_limit
                            when 0 then :not_available
                            else restriction_rule[:maximum_count] - send(restriction_rule[:class_name].pluralize).count
                            end) }
      end
    end
end
