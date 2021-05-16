# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'

module HexletCode
  class Error < StandardError; end

  def self.form_for(_user, &_block)
    yield if block_given?
    Tag.build('form', action: '#', method: 'post') {}
  end
end
