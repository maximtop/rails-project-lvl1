# frozen_string_literal: true

module HexletCode
  autoload(:Input, 'tag_builders/input')
  autoload(:Textarea, 'tag_builders/textarea')
  autoload(:Submit, 'tag_builders/submit')

  class FormBuilder
    attr_reader :fields

    def initialize(form_object)
      @form_object = form_object
      @fields = []
    end

    def input(name, options = {})
      # check if form_object has fields
      return unless @form_object.respond_to?(name)

      updated_options = options.except(:as)
      @fields << {
        name: name,
        value: @form_object[name],
        as: options.fetch(:as, :input),
        options: updated_options
      }
    end

    def submit(value = 'Save')
      @fields << { name: 'commit', value: value, as: :submit }
    end

    def get_tag_builder(type)
      tags_builders = {
        input: Input,
        submit: Submit,
        text: Textarea
      }
      tags_builders[type] || tags_builders[:input]
    end

    def build(url = '#')
      Tag.build('form', action: url, method: 'post') do
        result = @fields.map do |field|
          tag_builder = get_tag_builder(field[:as])
          options = { name: field[:name], value: field[:value], indentation_level: 1 }.merge(field[:options] || {})
          tag_builder.new(options).build
        end.join("\n")
        "\n#{result}\n"
      end
    end
  end
end
