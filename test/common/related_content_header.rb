def assert_related_content_header(data)
  assert_instance_of Puree::Model::RelatedContentHeader, data
  assert data.data?
  assert_instance_of String, data.uuid
  refute_empty data.uuid
  assert_instance_of String, data.title
  refute_empty data.title
  assert_instance_of String, data.type
  refute_empty data.type
end