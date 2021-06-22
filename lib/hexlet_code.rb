# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/tag'
require_relative 'hexlet_code/form_builder'

module HexletCode
  class Error < StandardError; end

  def self.form_for(user, **kwargs, &_block)
    form_builder = FormBuilder.new(user)
    yield form_builder if block_given?
    form_builder.build(kwargs.fetch(:url, '#'))
  end
end
