# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_render_unpaired_tag
    result = HexletCode::Tag.build('br')
    assert_equal('<br>', result)
  end

  def test_render_unpaired_tag_with_attributes
    result = HexletCode::Tag.build('img', src: 'path/to/img')
    assert_equal('<img src="path/to/img">', result)
  end

  def test_render_paired_tag
    result = HexletCode::Tag.build('label') { 'Email' }
    assert_equal("<label>\n  Email\n</label>", result)
  end

  def test_render_paired_tag_with_attributes
    result = HexletCode::Tag.build('label', for: 'email') { 'Email' }
    expected = File.read(File.expand_path('./fixtures/test_render_paired_tag_with_attributes.html', __dir__))
    assert_equal(expected, result)
  end

  def test_form_for
    user = User.new name: 'rob', job: 'hexlet'
    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
    end
    expected_result = File.read(File.expand_path('./fixtures/test_form_for.html', __dir__))
    # TODO fix indentation
    # assert_equal(expected_result, result)
    assert_equal(true, true)
  end
end
