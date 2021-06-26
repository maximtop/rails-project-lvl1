# frozen_string_literal: true

module HexletCode
  autoload(:Label, './label')

  class Input < TagBuilder
    def build
      name = options[:name]
      value = options[:value]
      indentation_level = options[:indentation_level]

      rest_options = options.except(:name, :value, :indentation_level)
      tag_options = { type: 'text', name: name, value: value }.merge(rest_options)

      label = Label.new(options).build
      input = Tag.build('input', **tag_options)

      "#{indent(label, indentation_level)}\n#{indent(input, indentation_level)}"
    end
  end
end
