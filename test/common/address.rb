def assert_address(data)
  assert_instance_of Puree::Model::Address, data
  assert data.data?
  assert_instance_of String, data.street
  refute_empty data.street
  assert_instance_of String, data.building
  refute_empty data.building
  assert_instance_of String, data.postcode
  refute_empty data.postcode
  assert_instance_of String, data.city
  refute_empty data.city
  assert_instance_of String, data.country
  refute_empty data.country
end