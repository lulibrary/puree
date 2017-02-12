require 'http'
require 'nokogiri'
require 'puree/configuration'
require 'puree/auth'
require 'puree/date'
require 'puree/extractor/base_extractor'
require 'puree/extractor/resource_extractor'
require 'puree/extractor/dataset_extractor'
require 'puree/extractor/download_extractor'
require 'puree/extractor/event_extractor'
require 'puree/extractor/journal_extractor'
require 'puree/extractor/organisation_extractor'
require 'puree/extractor/person_extractor'
require 'puree/extractor/project_extractor'
require 'puree/extractor/publication_extractor'
require 'puree/extractor/publisher_extractor'
require 'puree/extractor/server_extractor'
require 'puree/extractor/shared_extractor'
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
require 'puree/request'
require 'puree/version'

# Top level namespace
#
module Puree

  class << self

    include Puree::Configuration

  end

end