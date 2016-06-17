require 'httparty'
require 'nokogiri'
require 'puree/configuration'
require 'puree/date'
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