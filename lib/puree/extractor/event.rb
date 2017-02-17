module Puree

  module Extractor

    class Event < Puree::Extractor::Resource

      # @param url [String]
      def initialize(url:)
        super
        setup :event
      end      
 
      private

      def combine_metadata
        super
        @model.city = @extractor.city
        @model.country = @extractor.country
        @model.date = @extractor.date
        @model.description = @extractor.description
        @model.location = @extractor.location
        @model.title = @extractor.title
        @model.type = @extractor.type
        @metadata = @model
      end

    end

  end

end
