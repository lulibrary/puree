module Puree

  module Extractor

    # Event extractor.
    #
    class Event < Puree::Extractor::Resource

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        super
        # setup :event
      end      
 
      private

      # def combine_metadata
      #   super
      #   @model.city = @extractor.city
      #   @model.country = @extractor.country
      #   @model.date = @extractor.date
      #   @model.description = @extractor.description
      #   @model.location = @extractor.location
      #   @model.title = @extractor.title
      #   @model.type = @extractor.type
      #   @model
      # end

    end

  end

end
