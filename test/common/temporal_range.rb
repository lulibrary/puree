def assert_temporal_range(data)
  assert data.data?
  assert_instance_of Time, data.start
  assert_instance_of Time, data.end
end