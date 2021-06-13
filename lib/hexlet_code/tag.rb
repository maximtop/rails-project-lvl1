# frozen_string_literal: true

module HexletCode
  # Class used for tags building
  class Tag
    def self.build_attributes(attributes)
      attributes_strings = []
      attributes.each do |key, value|
        attributes_strings.push("#{key}=\"#{value}\"")
      end
      attributes_strings.join(' ')
    end

    def self.build(tag, **kwargs, &block)
      content = block_given? ? yield : ''
      attributes = build_attributes(kwargs)
      if block.nil?
        attributes.empty? ? "<#{tag}>" : "<#{tag} #{attributes}>"
      else
        attributes.empty? ? "<#{tag}>\n    #{content}\n</#{tag}>" : "<#{tag} #{attributes}>\n    #{content}\n</#{tag}>"
      end
    end
  end
end
