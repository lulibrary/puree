def assert_person_name(data)
  assert_instance_of Puree::Model::PersonName, data
  assert data.data?
  assert_instance_of String, data.first
  refute_empty data.first
  assert_instance_of String, data.last
  refute_empty data.last
end