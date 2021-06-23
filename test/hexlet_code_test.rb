# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

  def fixture(relative_path)
    File.read(File.expand_path(relative_path, __dir__))
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_ignored_inputs
    user = Struct.new(:name, keyword_init: true).new name: 'rob'
    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job ## would be ignored
    end
    expected = fixture('./fixtures/test_ignored_inputs.html')
    assert_equal(expected, result)
  end

  def test_form_for_label
    user = User.new job: 'hexlet'

    result = HexletCode.form_for user, url: 'foo' do |f|
      f.input :name, class: 'user-input'
      f.input :job
      f.submit
    end

    expected_result = fixture('./fixtures/test_form_for_label.html')
    assert_equal(expected_result, result)
  end

  def test_form_with_textarea
    user = User.new name: 'rob', job: 'hexlet'

    result = HexletCode.form_for user, url: '#' do |f|
      f.input :name
      f.input :job, as: :text, rows: 50, cols: 50
      f.submit 'Wow'
    end

    expected_result = fixture('./fixtures/test_form_with_textarea.html')
    assert_equal(expected_result, result)
  end
end
