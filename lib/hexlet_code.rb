# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'

module HexletCode
  class Error < StandardError; end

  def self.input(field_name, options = {})
    default_tag = :input
    (@fields ||= []) << { field_name: field_name, as: options.fetch(:as, default_tag) }
  end

  def self.get_tag(type)
    tags = {
      text: 'textarea',
      input: 'input'
    }
    tags[type]
  end

  def self.form_for(user, &_block)
    yield self if block_given?
    Tag.build('form', action: '#', method: 'post') do
      @fields.map do |field|
        field_name = field[:field_name]
        if field[:as] == 'text'
          Tag.build('textarea', cols: '20', rows: '40', name: field_name) { user[field_name] }
        else
          Tag.build('input', type: 'text', value: user[field_name], name: field_name)
        end
      end.join('\n')
    end
  end
end
