require 'http'
require 'nokogiri'

require 'puree/version'

require 'puree/util/date'

require 'puree/xml_extractor/shared'
require 'puree/xml_extractor/base'
require 'puree/xml_extractor/collection'
require 'puree/xml_extractor/resource'
require 'puree/xml_extractor/dataset'
require 'puree/xml_extractor/download'
require 'puree/xml_extractor/event'
require 'puree/xml_extractor/journal'
require 'puree/xml_extractor/organisation'
require 'puree/xml_extractor/person'
require 'puree/xml_extractor/project'
require 'puree/xml_extractor/publication'
require 'puree/xml_extractor/publisher'
require 'puree/xml_extractor/server'

require 'puree/api/map'
require 'puree/api/request'

require 'puree/model/resource'
require 'puree/model/dataset'
require 'puree/model/event'
require 'puree/model/journal'
require 'puree/model/organisation'
require 'puree/model/person'
require 'puree/model/project'
require 'puree/model/publication'
require 'puree/model/publisher'
require 'puree/model/temporal_range'

require 'puree/extractor/resource'
require 'puree/extractor/dataset'
require 'puree/extractor/event'
require 'puree/extractor/journal'
require 'puree/extractor/organisation'
require 'puree/extractor/person'
require 'puree/extractor/project'
require 'puree/extractor/publication'
require 'puree/extractor/publisher'
require 'puree/extractor/collection'
require 'puree/extractor/download'
require 'puree/extractor/server'

def random_uuid(resource)
  c = Puree::Extractor::Collection.new resource: resource,
                            url: ENV['PURE_URL']
  c.basic_auth username: ENV['PURE_USERNAME'],
               password: ENV['PURE_PASSWORD']
  collection = c.find limit: 1,
                      offset: rand(0..c.count-1)
  collection[0]['uuid']
end

def request(resource)
  @uuid = random_uuid(resource)
  resource_class = 'Puree::Extractor::' + resource.to_s.capitalize
  @extractor = Object.const_get(resource_class).new url: ENV['PURE_URL']
  @extractor.basic_auth username: ENV['PURE_USERNAME'],
                password: ENV['PURE_PASSWORD']
  @p = @extractor.find uuid: @uuid
end

def random_uuid_open(resource)
  c = Puree::Extractor::Collection.new resource: resource,
                            url: ENV['PURE_URL_OPEN']
  collection = c.find limit: 1,
                      offset: rand(0..c.count-1)
  collection[0]['uuid']
end

def request_open(resource)
  @uuid = random_uuid_open(resource)
  resource_class = 'Puree::Extractor::' + resource.to_s.capitalize
  @extractor = Object.const_get(resource_class).new url: ENV['PURE_URL_OPEN']
  @p = @extractor.find uuid: @uuid
end

def from_file(resource)
  before(:all) do
    request resource
    @filename = "#{ENV['PURE_FILE_PATH']}resource.to_s.#{@uuid}.xml"
    File.write(@filename, @extractor.response.body)
    @p = @extractor.set_content File.read(@filename)
  end

  it '#created' do
    expect(@p.created).not_to be_empty
  end

  after(:all) do
    File.delete @filename if File.exists? @filename
  end
end