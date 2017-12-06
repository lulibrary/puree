require 'http'
require 'nokogiri'

require 'puree/version'

require 'puree/util/date'
require 'puree/util/string'

require 'puree/xml_extractor/mixins/associated_mixin'
require 'puree/xml_extractor/mixins/doi_mixin'
require 'puree/xml_extractor/mixins/event_mixin'
require 'puree/xml_extractor/mixins/external_organisation_mixin'
require 'puree/xml_extractor/mixins/pages_mixin'
require 'puree/xml_extractor/mixins/page_range_mixin'
require 'puree/xml_extractor/mixins/peer_reviewed_mixin'
require 'puree/xml_extractor/mixins/workflow_mixin'

require 'puree/xml_extractor/shared'
require 'puree/xml_extractor/base'
require 'puree/xml_extractor/collection'
require 'puree/xml_extractor/resource'
require 'puree/xml_extractor/dataset'
require 'puree/xml_extractor/download'
require 'puree/xml_extractor/event'
require 'puree/xml_extractor/journal'
require 'puree/xml_extractor/organisation'
require 'puree/xml_extractor/external_organisation'
require 'puree/xml_extractor/person'
require 'puree/xml_extractor/project'

require 'puree/xml_extractor/publication'
require 'puree/xml_extractor/thesis'
require 'puree/xml_extractor/doctoral_thesis'
require 'puree/xml_extractor/masters_thesis'
require 'puree/xml_extractor/journal_article'
require 'puree/xml_extractor/paper'
require 'puree/xml_extractor/conference_paper'
require 'puree/xml_extractor/paper'

require 'puree/xml_extractor/publisher'
require 'puree/xml_extractor/server'

require 'puree/api/map'
require 'puree/api/request'
require 'puree/api/person_request'
require 'puree/api/configuration'
require 'puree/api/authentication'

require 'puree/model/helper/validation'
require 'puree/model/structure'

require 'puree/model/resource'
require 'puree/model/dataset'
require 'puree/model/download_header'
require 'puree/model/event'
require 'puree/model/event_header'
require 'puree/model/external_organisation'
require 'puree/model/journal'
require 'puree/model/journal_header'
require 'puree/model/link'
require 'puree/model/organisation'
require 'puree/model/person'
require 'puree/model/project'

require 'puree/model/publication'
require 'puree/model/thesis'
require 'puree/model/doctoral_thesis'
require 'puree/model/masters_thesis'
require 'puree/model/journal_article'
require 'puree/model/paper'
require 'puree/model/conference_paper'
require 'puree/model/paper'

require 'puree/model/publisher'
require 'puree/model/related_content_header'
require 'puree/model/spatial_point'

require 'puree/model/address'
require 'puree/model/copyright_license'
require 'puree/model/event_header'
require 'puree/model/external_organisation_header'
require 'puree/model/file'
require 'puree/model/legal_condition'
require 'puree/model/organisation_header'
require 'puree/model/endeavour_person'
require 'puree/model/person_name'
require 'puree/model/publication_status'
require 'puree/model/server'
require 'puree/model/temporal_range'

require 'puree/extractor/resource'
require 'puree/extractor/dataset'
require 'puree/extractor/event'
require 'puree/extractor/external_organisation'
require 'puree/extractor/journal'
require 'puree/extractor/organisation'
require 'puree/extractor/person'
require 'puree/extractor/project'

require 'puree/extractor/publication'
require 'puree/extractor/thesis'
require 'puree/extractor/doctoral_thesis'
require 'puree/extractor/masters_thesis'
require 'puree/extractor/journal_article'
require 'puree/extractor/paper_base'
require 'puree/extractor/conference_paper'
require 'puree/extractor/paper'

require 'puree/extractor/publisher'
require 'puree/extractor/collection'
require 'puree/extractor/download'
require 'puree/extractor/server'

require 'puree/query/funding'
require 'puree/query/person'

def config
  {
    url:      ENV['PURE_URL'],
    username: ENV['PURE_USERNAME'],
    password: ENV['PURE_PASSWORD']
  }
end

def config_open
  {
      url: ENV['PURE_URL_OPEN']
  }
end

def request(resource)
  @extractor = Puree::Extractor::Collection.new config: config,
                                                resource: resource
  @p = @extractor.random_resource
end

def request_open(resource)
  @extractor = Puree::Extractor::Collection.new resource: resource,
                                                config: config_open
  @p = @extractor.random_resource
end

def resource_header
  it '#uuid' do
    expect(@p.uuid).to be_a String if @p.uuid
  end

  it '#created' do
    expect(@p.created).to be_a Time if @p.created
  end

  it '#modified' do
    expect(@p.modified).to be_a Time if @p.modified
  end

  it '#locale' do
    expect(@p.locale).to be_a String if @p.locale
  end
end