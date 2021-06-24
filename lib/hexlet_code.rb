# frozen_string_literal: true

module HexletCode
  autoload(:VERSION, 'hexlet_code/version')
  autoload(:Tag, 'hexlet_code/tag')
  autoload(:FormBuilder, 'hexlet_code/form_builder')

  class Error < StandardError; end

  def self.form_for(user, **kwargs, &block)
    form_builder = FormBuilder.new(user)
    block.call(form_builder) if block_given?
    form_builder.build(kwargs.fetch(:url, '#'))
  end
end
