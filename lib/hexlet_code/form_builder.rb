# frozen_string_literal: true

module HexletCode
  class FormBuilder
    attr_reader :fields

    def initialize(user)
      @user = user
    end

    def input(name, options = {})
      # check if user has fields
      return unless @user.members.include?(name)

      updated_options = options.except(:as)
      (@fields ||= []) << { name: name, value: @user[name], as: options.fetch(:as, :input), options: updated_options }
    end

    def submit(value = 'Save')
      (@fields ||= []) << { name: 'commit', value: value, as: :submit }
    end

    def label_builder(name)
      Tag.build('label', for: name) { name.capitalize }
    end

    def indent(tag_string, indentation_level)
      tab = ' ' # Spaces
      indentation_size = 4
      indentation = tab * indentation_size * indentation_level
      "#{indentation}#{tag_string}"
    end

    def input_builder(options)
      name = options[:name]
      value = options[:value]
      indentation_level = options[:indentation_level]

      rest_options = options.except(:name, :value, :indentation_level)
      tag_options = { type: 'text', name: name, value: value }.merge(rest_options)

      label = label_builder(options[:name])
      input = Tag.build('input', **tag_options)

      "#{indent(label, indentation_level)}\n#{indent(input, indentation_level)}"
    end

    def submit_builder(options)
      name = options.fetch(:name)
      value = options.fetch(:value)
      indentation_level = options.fetch(:indentation_level, 0)

      rest_options = options.except(:name, :value, :indentation_level)
      tag_options = { type: 'submit', name: name, value: value }.merge(rest_options)
      submit = Tag.build('input', **tag_options)
      indent(submit, indentation_level)
    end

    def text_builder(options)
      name = options.fetch(:name)
      value = options.fetch(:value)
      indentation_level = options.fetch(:indentation_level, 0)

      rest_options = options.except(:name, :value, :indentation_level)
      tag_options = { name: name }.merge(rest_options)

      label = label_builder(name)
      textarea = Tag.build('textarea', **tag_options) { value }
      "#{indent(label, indentation_level)}\n#{indent(textarea, indentation_level)}"
    end

    def get_tag_builder(type)
      tags_builders = {
        input: ->(options) { input_builder(options) },
        submit: ->(options) { submit_builder(options) },
        text: ->(options) { text_builder(options) }
      }
      tags_builders[type] || tags_builders[:input]
    end

    def build(url = '#')
      Tag.build('form', action: url, method: 'post') do
        result = @fields.map do |field|
          tag_builder = get_tag_builder(field[:as])
          options = { name: field[:name], value: field[:value], indentation_level: 1 }.merge(field[:options] || {})
          tag_builder.call(options)
        end.join("\n")
        "\n#{result}\n"
      end
    end
  end
end
