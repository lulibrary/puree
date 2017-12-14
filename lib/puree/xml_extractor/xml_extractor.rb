require 'nokogiri'

require 'puree/xml_extractor/mixins/research_output_mixin'
require 'puree/xml_extractor/mixins/abstract_mixin'
require 'puree/xml_extractor/mixins/description_mixin'
require 'puree/xml_extractor/mixins/doi_mixin'
require 'puree/xml_extractor/mixins/event_mixin'
require 'puree/xml_extractor/mixins/external_organisation_mixin'
require 'puree/xml_extractor/mixins/identifier_mixin'
require 'puree/xml_extractor/mixins/keyword_mixin'
require 'puree/xml_extractor/mixins/organisational_unit_mixin'
require 'puree/xml_extractor/mixins/owner_mixin'
require 'puree/xml_extractor/mixins/pages_mixin'
require 'puree/xml_extractor/mixins/person_mixin'
require 'puree/xml_extractor/mixins/page_range_mixin'
require 'puree/xml_extractor/mixins/peer_reviewed_mixin'
require 'puree/xml_extractor/mixins/workflow_mixin'
require 'puree/xml_extractor/mixins/title_mixin'
require 'puree/xml_extractor/mixins/type_mixin'

require 'puree/xml_extractor/shared'
require 'puree/xml_extractor/base'
require 'puree/xml_extractor/collection_delme'
require 'puree/xml_extractor/resource'
require 'puree/xml_extractor/dataset'
require 'puree/xml_extractor/download'
require 'puree/xml_extractor/event'
require 'puree/xml_extractor/journal'
require 'puree/xml_extractor/organisational_unit'
require 'puree/xml_extractor/external_organisation'
require 'puree/xml_extractor/person'
require 'puree/xml_extractor/project'

require 'puree/xml_extractor/research_output'
require 'puree/xml_extractor/thesis'
require 'puree/xml_extractor/doctoral_thesis'
require 'puree/xml_extractor/masters_thesis'
require 'puree/xml_extractor/journal_article'
require 'puree/xml_extractor/paper'
require 'puree/xml_extractor/conference_paper'

require 'puree/xml_extractor/collection'

require 'puree/xml_extractor/publisher'
require 'puree/xml_extractor/server'

module Puree

  # An XMLExtractor manages the extraction of metadata from XML into Ruby
  # data structures.
  #
  module XMLExtractor

  end

end