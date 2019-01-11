def assert_name_header(data)
  assert data.data?
  assert_instance_of String, data.uuid
  refute_empty data.uuid
  assert_instance_of String, data.name
  refute_empty data.name
  assert_instance_of String, data.type
  refute_empty data.type
end