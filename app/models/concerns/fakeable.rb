module Fakeable
  extend ActiveSupport::Concern

  def fake_value
    case self
    when RegularProperty
      return nil if !required? and rand(0..9) < 1
      case type
      when "string"
        if !!(code =~ /name/)
          fake_name
        elsif !!(code =~ /address/)
          fake_address
        elsif !!(code =~ /mobile/)
          "1#{rand(1000000000..9999999999)}"
        elsif !!(code =~ /number/)
          "#{rand(1..9999)}"
        else
          fake_sentence
        end
      when "text"
        Faker::Lovecraft.paragraph(5)
      when "integer", "float", "decimal"
        if !!(code =~ /latitude/)
          BigDecimal.new(Faker::Address.latitude).round(6)
        elsif !!(code =~ /longitude/)
          BigDecimal.new(Faker::Address.longitude).round(6)
        else
          if numericality_validation.present?
            minimum = numericality_validation.minimum || 0
            maximum = numericality_validation.maximum || 9999
            numericality_validation.only_integer? ? rand(minimum..maximum).round : rand(minimum..maximum)
          else
            rand(1..9999)
          end
        end
      when "date"
        Date.current - rand(1..365).days
      when "time"
        Time.current - rand(1..86_400).seconds
      when "datetime"
        Time.current - rand(1..10_080).minutes
      when "boolean"
        Faker::Boolean.boolean(0.7)
      when "array"
      end
    when EnumerationProperty
      elements.sample.name
    when FileProperty
      Faker::Avatar.image
    when Cascade
      fake_name
    end
  end

  protected
    def fake_name
      [Faker::Ancient.god, Faker::Ancient.primordial, Faker::Ancient.titan, Faker::Ancient.hero, Faker::BackToTheFuture.character, Faker::Book.title, Faker::Cat.name, Faker::Coffee.blend_name, Faker::Food.dish, Faker::GameOfThrones.character, Faker::HarryPotter.character, Faker::LordOfTheRings.character, Faker::Pokemon.name, Faker::Science.scientist, Faker::WorldOfWarcraft.hero, Faker::Zelda.character].sample
    end

    def fake_address
      "#{Faker::Address.building_number}, #{Faker::Address.street_name}, #{Faker::Address.street_address}, #{Faker::Address.city}"
    end

    def fake_sentence
      Faker::Lovecraft.sentence
    end
end
