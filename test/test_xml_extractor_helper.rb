require 'test_helper'

def asserts_resource(x)
  assert_instance_of Time, x.created_at

  assert_instance_of String, x.created_by

  assert_instance_of Time, x.modified_at

  assert_instance_of String, x.modified_by

  assert_instance_of String, x.id

  assert_instance_of String, x.uuid
end

def collection_size
  3
end
