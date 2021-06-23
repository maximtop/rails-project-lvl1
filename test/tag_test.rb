# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
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
    assert_equal('<label>Email</label>', result)
  end

  def test_render_paired_tag_with_attributes
    result = HexletCode::Tag.build('label', for: 'email') { 'Email' }
    expected = File.read(File.expand_path('./fixtures/test_render_paired_tag_with_attributes.html', __dir__))
    assert_equal(expected, result)
  end
end
