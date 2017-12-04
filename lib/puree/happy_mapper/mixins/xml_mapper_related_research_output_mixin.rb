module Puree
  module Mapper
    module RelatedResearchOutputMixin
      def self.included(base)
        # @return [Array<Puree::Mapper::RelatedResearchOutputHeader>]
        base.has_many :related_research_outputs, Puree::Mapper::RelatedResearchOutputHeader
      end
    end
  end
end
