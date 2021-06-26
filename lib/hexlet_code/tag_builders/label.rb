# frozen_string_literal: true

module HexletCode
  class Label < TagBuilder
    def build
      name = options[:name]
      Tag.build('label', for: name) { name.capitalize }
    end
  end
end
