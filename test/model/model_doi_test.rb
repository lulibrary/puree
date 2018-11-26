require 'test_rest_helper'

class TestModelDOI < Minitest::Test

  def instance(str)
    Puree::Model::DOI.new str
  end

  def test_instance
    m = instance 'foo'
    assert_instance_of Puree::Model::DOI, m
  end

  def asserts_encode
    str = 'https://doi.org/10.1002/1097-458X(200101)39:1<9::AID-MRC776>3.0.CO;2-3'
    m = instance str
    assert_equal 0, m.encode.scan('https://doi.org/').length
  end

  def asserts_to_url
    str = 'https://doi.org/10.1002/1097-458X(200101)39:1<9::AID-MRC776>3.0.CO;2-3'
    m = instance str
    assert_equal 1, m.encode.scan('https://doi.org/').length
  end

  def asserts_lt_gt(str)
    m = instance str

    assert_equal m.to_s, str

    assert_equal true, m.valid?

    assert_equal 0, m.encode.scan('<').length
    assert_equal 0, m.encode.scan('&lt;').length
    assert_equal 1, m.encode.scan('%3C').length

    assert_equal 0, m.encode.scan('>').length
    assert_equal 0, m.encode.scan('&gt;').length
    assert_equal 1, m.encode.scan('%3E').length

    assert_equal 0, m.to_url.scan('<').length
    assert_equal 0, m.to_url.scan('&lt;').length
    assert_equal 1, m.to_url.scan('%3C').length

    assert_equal 0, m.to_url.scan('>').length
    assert_equal 0, m.to_url.scan('&gt;').length
    assert_equal 1, m.to_url.scan('%3E').length
  end

  def test_lt_gt_1
    asserts_lt_gt 'https://doi.org/10.1002/1097-458X(200101)39:1<9::AID-MRC776>3.0.CO;2-3'
  end

  def test_lt_gt_2
    asserts_lt_gt 'https://doi.org/10.1002/1097-458X(200101)39:1&lt;9::AID-MRC776&gt;3.0.CO;2-3'
  end

  def test_lt_gt_3
    asserts_lt_gt 'https://doi.org/10.1002/1097-458X(200101)39:1<9::AID-MRC776&gt;3.0.CO;2-3'
  end

  def test_lt_gt_4
    asserts_lt_gt 'https://doi.org/10.1002/1097-458X(200101)39:1&lt;9::AID-MRC776>3.0.CO;2-3'
  end

  def test_lt_gt_5
    asserts_lt_gt 'https://doi.org/10.1002/1097-458X(200101)39:1&lt;9::AID-MRC776%3E3.0.CO;2-3'
  end

  def test_not_a_doi
    m = instance 'foo'
    assert_equal false, m.valid?
    assert_nil m.encode
    assert_nil m.to_url
  end

end





