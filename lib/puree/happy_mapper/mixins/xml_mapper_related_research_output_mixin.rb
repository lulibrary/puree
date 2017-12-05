module Purifier
  module RelatedResearchOutputMixin
    def self.included(base)
      # @return [Array<Purifier::RelatedResearchOutputHeader>]
      base.has_many :related_research_outputs, Purifier::RelatedResearchOutputHeader
    end
  end
end
