require_relative 'person_name'

def assert_endeavour_person(data)
  assert_instance_of Puree::Model::EndeavourPerson, data
  assert data.data?
  assert_instance_of String, data.uuid
  refute_empty data.uuid
  assert_instance_of String, data.role
  refute_empty data.role
  assert_person_name data.name
end