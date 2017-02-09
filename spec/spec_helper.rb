require 'http'
require 'nokogiri'
require 'puree/configuration'
require 'puree/date'
require 'puree/extractor/generic_extractor'
require 'puree/extractor/dataset_extractor'
require 'puree/extractor/event_extractor'
require 'puree/extractor/organisation_extractor'
require 'puree/extractor/person_extractor'
require 'puree/extractor/project_extractor'
require 'puree/extractor/publication_extractor'
require 'puree/map'
require 'puree/resource'
require 'puree/dataset'
require 'puree/event'
require 'puree/journal'
require 'puree/organisation'
require 'puree/person'
require 'puree/project'
require 'puree/publication'
require 'puree/publisher'
require 'puree/collection'
require 'puree/download'
require 'puree/server'

module Puree

  class << self

    include Puree::Configuration

  end

end

def auth
  Puree.base_url   = ENV['PURE_BASE_URL']
  Puree.username   = ENV['PURE_USERNAME']
  Puree.password   = ENV['PURE_PASSWORD']
  Puree.basic_auth = true
end

def random_uuid(resource)
  c = Puree::Collection.new resource: resource
  collection = c.find limit: 1,
                      offset: rand(0..c.count-1),
                      full: false
  collection[0]['uuid']
end

def request(resource)
  auth
  @uuid = random_uuid(resource)
  resource_class = 'Puree::' + resource.to_s.capitalize
  @p = Object.const_get(resource_class).new
  @metadata = @p.find uuid: @uuid
end