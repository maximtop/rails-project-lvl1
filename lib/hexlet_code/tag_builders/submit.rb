# frozen_string_literal: true

module HexletCode
  class Submit
    def build
      name = options.fetch(:name)
      value = options.fetch(:value)
      indentation_level = options.fetch(:indentation_level, 0)

      rest_options = options.except(:name, :value, :indentation_level)
      tag_options = { type: 'submit', name: name, value: value }.merge(rest_options)
      submit = Tag.build('input', **tag_options)
      indent(submit, indentation_level)
    end
  end
end
