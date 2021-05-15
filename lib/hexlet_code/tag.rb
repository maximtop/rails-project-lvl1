# frozen_string_literal: true

module HexletCode
  # Class used for tags building
  class Tag
    def self.build_attributes(attributes)
      res = ''
      attributes.each do |key, value|
        res += "#{key}=\"#{value}\""
      end
      res
    end

    def self.build(tag, **kwargs, &_block)
      content = yield if block_given?
      attributes = build_attributes(kwargs)
      if content.nil?
        attributes.empty? ? "<#{tag}>" : "<#{tag} #{attributes}>"
      else
        attributes.empty? ? "<#{tag}>#{content}</#{tag}>" : "<#{tag} #{attributes}>#{content}</#{tag}>"
      end
    end
  end
end
