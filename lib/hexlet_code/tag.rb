# frozen_string_literal: true

module HexletCode
  # Class used for tags building
  class Tag
    def self.build_attributes(attributes)
      attributes_strings = []
      attributes.each do |key, value|
        attributes_strings.push("#{key}=\"#{value}\"") unless value.nil?
      end
      attributes_strings.join(' ')
    end

    def self.build(tag, **kwargs, &block)
      content = block_given? ? yield : ''
      attributes = build_attributes(kwargs)
      if block.nil?
        attributes.empty? ? "<#{tag}>" : "<#{tag} #{attributes}>"
      else
        attributes.empty? ? "<#{tag}>#{content}</#{tag}>" : "<#{tag} #{attributes}>#{content}</#{tag}>"
      end
    end
  end
end
