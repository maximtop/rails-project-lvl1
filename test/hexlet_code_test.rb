# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_render_unpaired_tag
    result = HexletCode::Tag.build('br')
    assert_equal(result, '<br>')
  end

  def test_render_unpaired_tag_with_attributes
    result = HexletCode::Tag.build('img', src: 'path/to/img')
    assert_equal(result, '<img src="path/to/img">')
  end

  def test_render_paired_tag
    result = HexletCode::Tag.build('label') { 'Email' }
    assert_equal(result, '<label>Email</label>')
  end

  def test_render_paired_tag_with_attributes
    result = HexletCode::Tag.build('label', for: 'email') { 'Email' }
    assert_equal(result, '<label for="email">Email</label>')
  end
end