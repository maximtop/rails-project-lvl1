# frozen_string_literal: true

module HexletCode
  # Class used for tags building
  class Tag
    def self.build_attributes(attributes)
      attributes_string = attributes
                          .map { |key, value| "#{key}=\"#{value}\"" unless value.nil? }
                          .compact
                          .join(' ')

      return attributes_string if attributes_string.empty?

      " #{attributes_string}"
    end

    def self.build(tag, **kwargs, &_block)
      content = yield if block_given?
      attributes = build_attributes(kwargs)

      return "<#{tag}#{attributes}>" if content.nil?

      "<#{tag}#{attributes}>#{content}</#{tag}>"
    end
  end
end
