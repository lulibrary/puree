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
require 'puree/model/event'
require 'puree/model/journal'
require 'puree/model/link'
require 'puree/model/organisation'
require 'puree/model/person'
require 'puree/model/project'
require 'puree/model/publication'
require 'puree/model/publisher'
require 'puree/model/related_content_header'
require 'puree/model/spatial_point'

require 'puree/model/address'
require 'puree/model/copyright_license'
require 'puree/model/event_header'
require 'puree/model/file'
require 'puree/model/organisation_header'
require 'puree/model/endeavour_person'
require 'puree/model/person_name'
require 'puree/model/publication_status'
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

def request(resource)
  @extractor = Puree::Extractor::Collection.new resource: resource,
                            url: ENV['PURE_URL']
  @extractor.basic_auth username: ENV['PURE_USERNAME'],
               password: ENV['PURE_PASSWORD']
  collection = @extractor.find limit: 1,
                      offset: rand(0..@extractor.count-1)
  @p = collection[0]
end

# def request(resource)
#   @uuid = random_uuid(resource)
#   resource_class = 'Puree::Extractor::' + resource.to_s.capitalize
#   @extractor = Object.const_get(resource_class).new url: ENV['PURE_URL']
#   @extractor.basic_auth username: ENV['PURE_USERNAME'],
#                 password: ENV['PURE_PASSWORD']
#   @p = @extractor.find uuid: @uuid
# end

def request_open(resource)
  @extractor = Puree::Extractor::Collection.new resource: resource,
                            url: ENV['PURE_URL_OPEN']
  collection = @extractor.find limit: 1,
                      offset: rand(0..@extractor.count-1)
  @p = collection[0]
end

# def request_open(resource)
#   @uuid = random_uuid_open(resource)
#   resource_class = 'Puree::Extractor::' + resource.to_s.capitalize
#   @extractor = Object.const_get(resource_class).new url: ENV['PURE_URL_OPEN']
#   @p = @extractor.find uuid: @uuid
# end

def from_file(resource)
  before(:all) do
    request resource
    collection_extractor = Puree::Extractor::Collection.new resource: resource,
                                                            url: ENV['PURE_URL']
    collection_extractor.basic_auth username: ENV['PURE_USERNAME'],
                                    password: ENV['PURE_PASSWORD']
    collection_result = collection_extractor.find limit: 1,
                              offset: rand(0..collection_extractor.count-1)
    resource_class = 'Puree::Extractor::' + resource.to_s.capitalize
    resource_extractor = Object.const_get(resource_class).new url: ENV['PURE_URL']
    resource_extractor.basic_auth username: ENV['PURE_USERNAME'],
                                  password: ENV['PURE_PASSWORD']
    resource_extractor.find uuid: collection_result[0]['uuid']
    @filename = "#{ENV['PURE_FILE_PATH']}resource.to_s.#{@uuid}.xml"
    xml = resource_extractor.response.body
    File.write(@filename, xml)
    resource_extractor.set_content File.read(@filename)
    @p = resource_extractor.metadata
  end

  header

  after(:all) do
    File.delete @filename if File.exists? @filename
  end
end

def header
  it '#uuid' do
    expect(@p.uuid).to be_an_instance_of(String) if @p.uuid
  end

  it '#created' do
    expect(@p.created).to be_an_instance_of(Time) if @p.created
  end

  it '#modified' do
    expect(@p.modified).to be_an_instance_of(Time) if @p.modified
  end

  it '#locale' do
    expect(@p.locale).to be_an_instance_of(String) if @p.locale
  end
end