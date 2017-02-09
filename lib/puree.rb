require 'http'
require 'nokogiri'
require 'puree/configuration'
require 'puree/date'
require 'puree/extractor/generic_extractor'
require 'puree/extractor/dataset_extractor'
require 'puree/extractor/event_extractor'
require 'puree/extractor/organisation_extractor'
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
require 'puree/version'

# Top level namespace
#
module Puree

  class << self

    include Puree::Configuration

  end

end