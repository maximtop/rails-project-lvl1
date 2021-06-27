# frozen_string_literal: true

module HexletCode
  class TagBuilder
    def initialize(options)
      @options = options
    end

    def indent(tag_string, indentation_level)
      tab = ' ' # Spaces
      indentation_size = 4
      indentation = tab * indentation_size * indentation_level
      "#{indentation}#{tag_string}"
    end

    def build
      throw 'Render should be implemented'
    end
  end
end
