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

      (@fields ||= []) << { name: name, value: @user[name], as: options.fetch(:as, :input) }
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

    def input_builder(name, value, indentation_level = 0)
      label = label_builder(name)
      input = Tag.build('input', type: 'text', name: name, value: value)
      "#{indent(label, indentation_level)}\n#{indent(input, indentation_level)}"
    end

    def submit_builder(name, value, indentation_level = 0)
      submit = Tag.build('input', type: 'submit', name: name, value: value)
      indent(submit, indentation_level)
    end

    # def text_builder(name, value)
    #   label = Tag.build('label', for: name) { name }
    #   input = Tag.build('textarea', type: text, value: value, name: name)
    #   "#{label}\n#{input}"
    # end

    def get_tag_builder(type)
      tags_builders = {
        input: ->(name, value, indentation_level) { input_builder(name, value, indentation_level) },
        submit: ->(name, value, indentation_level) { submit_builder(name, value, indentation_level) }
        # text: ->(name, value) { text_builder(name, value) }
      }
      tags_builders[type]
    end

    def build
      Tag.build('form', action: '#', method: 'post') do
        result = @fields.map do |field|
          tag_builder = get_tag_builder(field[:as])
          tag_builder.call(field[:name], field[:value], 1)
        end.join("\n")
        "\n#{result}\n"
      end
    end
  end
end
