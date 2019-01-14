require 'test_model_helper'

class TestPersonName < Minitest::Test

  def person_name_new
    Puree::Model::PersonName.new
  end

  def test_new
    assert_instance_of Puree::Model::PersonName, person_name_new
  end

  def person_name
    name = person_name_new
    name.first = 'Foo'
    name.last = 'Bar'
    name
  end

  def test_first_last
    assert_equal person_name.first_last, 'Foo Bar'
  end

  def test_last_first
    assert_equal person_name.last_first, 'Bar, Foo'
  end

  def test_initial_last
    assert_equal person_name.initial_last, 'F. Bar'
  end

  def test_last_initial
    assert_equal person_name.last_initial, 'Bar, F.'
  end

end

