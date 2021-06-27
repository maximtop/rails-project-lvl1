# frozen_string_literal: true

module HexletCode
  autoload(:TagBuilder, 'hexlet_code/tag_builders/tag_builder')

  class Textarea < TagBuilder
    def build
      name = @options.fetch(:name)
      value = @options.fetch(:value)
      indentation_level = @options.fetch(:indentation_level, 0)

      rest_options = @options.except(:name, :value, :indentation_level)
      tag_options = { name: name }.merge(rest_options)

      # FIXME: consider indentation in the every tag builder
      label = Label.new(@options).build
      textarea = Tag.build('textarea', **tag_options) { value }
      "#{indent(label, indentation_level)}\n#{indent(textarea, indentation_level)}"
    end
  end
end
