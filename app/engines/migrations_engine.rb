class MigrationsEngine < ApplicationEngine

  def compile
    @project.models.each do |model|
      @project.source_codes.create!(prefix: ["db", "migrate"],
        file_name: "#{model.created_at.strftime('%Y%m%d%H%M%S')}_create_#{model.code.pluralize}.rb",
        content: content_for(model))
    end
  end

  protected
    def content_for model
      "class Create#{model.code.camelize} < ActiveRecord::Migration[5.1]\n" +
      "def change\n" +
      "create_table :#{model.code.pluralize} do |t|\n" +
      columns(model) + "\n" +
      "end\n" +
      "end\n" +
      "end"
    end

    def columns model
      [].tap do |result|
        model.cascades_as_destination.each do |cascade|
          cascade.redundancies.each do |cascade_redundancy|
            result << "t.references :#{cascade_redundancy.model.code}#{", null: false" unless cascade.optional?}"
          end
          result << "t.references :#{cascade.source.code}#{", null: false" unless cascade.optional?}"
        end
        if model.authenticatable.present?
          result << "t.string :#{model.authenticatable.account_name}, limit: 32, null: false"
          result << "t.string :hashed_password, limit: 32, null: false"
        end
        model.properties.each do |property|
          case property
          when RegularProperty
            case property.type
            when "string", "text"
              result << ([].tap do |line|
                line << "t.#{property.type} :#{property.code}"
                line << "limit: #{property.length_validation.maximum}" if property.length_validation&.maximum.present?
                line << "null: false" if property.presence_validation.present?
              end.join(", "))
            when "integer", "float", "boolean", "date", "time", "datetime"
              result << ([].tap do |line|
                line << "t.#{property.type} :#{property.code}"
                line << "null: false" if property.presence_validation.present?
              end.join(", "))
            when "decimal"
              result << ([].tap do |line|
                line << "t.decimal :#{property.code}"
                line << "precision: #{property.precision}"
                line << "scale: #{property.scale}"
                line << "null: false" if property.presence_validation.present?
              end.join(", "))
            when "array"
              result << ([].tap do |line|
                line << "t.string :#{property.code}"
                line << "limit: 2000"
                line << "null: false" if property.presence_validation.present?
              end.join(", "))
            end
          when EnumerationProperty
            result << ([].tap do |line|
              line << "t.string :#{property.code}"
              line << "limit: 100"
              line << "null: false" if property.presence_validation.present?
            end.join(", "))
          when HashProperty
            result << ([].tap do |line|
              line << "t.string :#{property.code}"
              line << "limit: 2000"
              line << "null: false" if property.presence_validation.present?
            end.join(", "))
          when FileProperty
            result << ([].tap do |line|
              line << "t.string :#{property.code}"
              line << "limit: 100"
              line << "null: false" if property.presence_validation.present?
            end.join(", "))
          end
        end
        if model.sortable.present?
          result << "t.integer :position, null: false"
        end
        if model.trashable.present?
          result << "t.boolean :trashed, default: false, null: false"
        end
        if model.state_machine.present?
          result << "t.string :state, limit: 100, null: false"
        end
      end.join("\n")
    end
end
