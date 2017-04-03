module Puree

  module XMLExtractor

    # Bibliographical note extractor mixin.
    #
    module BibliographicalNoteMixin

      # @return [String, nil]
      def bibliographical_note
        xpath_query_for_single_value('/bibliographicalNote')
      end

    end

  end
end
