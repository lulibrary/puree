module Puree
  module Extractor

    # Thesis extractor.
    #
    class Thesis < Puree::Extractor::Publication

      # @option (see Puree::Extractor::Resource#initialize)
      def initialize(config)
        set_model_type 'thesis'
        super
      end

      private

      def combine_metadata
        super

        thesis_types = ["Master's Thesis", 'Doctoral Thesis']
        return nil if !thesis_types.include? @model.type

        @model.award_date = @extractor.award_date
        @model.awarding_institution = @extractor.awarding_institution
        @model.doi = @extractor.doi
        @model.pages = @extractor.pages
        @model.qualification = @extractor.qualification
        @model.sponsors = @extractor.sponsors
        @model
      end

    end

  end
end
