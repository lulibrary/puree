require 'test_helper'

def client
  Puree::REST::Client.new config
end

def instance(klass)
  Object.const_get(klass).new config
end

def resource_klass(resource)
  "Puree::REST::#{titleize(resource)}"
end

def resource_instance(resource)
  klass = resource_klass resource
  Object.const_get(klass).new config
end

def resource_count(resource)
  r = resource_instance resource
  response = r.all params: { size: 0 }, accept: :json
  hash = JSON.parse response
  hash['count']
end

def random_singleton(resource)
  count = resource_count resource
  return unless count > 0
  # get random offset
  offset = rand(0..count - 1)
  # get random record
  r = resource_instance resource
  response = r.all params: { size: 1, offset: offset }, accept: :json
  hash = JSON.parse response
  hash['items'][0]
end

def random_singleton_uuid(resource)
  hash = random_singleton resource
  return unless hash
  hash['uuid']
end

# Assumes underscore as separator.
# e.g. foo_bar becomes FooBar
#
def titleize(x)
  arr = "#{x}".split('_')
  caps = arr.map { |i| i.capitalize }
  caps.join
end

def resources
  %i(
    activity
    application
    classification_scheme
    curricula_vitae
    dataset
    equipment
    event
    external_organisation
    external_person
    impact
    journal
    organisational_unit
    person
    press_media
    prize
    project
    publisher
    research_output
  )
end

def meta_methods
  %i(
  orderings
  renderings
  )
end