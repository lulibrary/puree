module Puree

  # Publisher resource
  #
  class Publisher < Resource

    # @param base_url [String]
    def initialize(base_url: nil)
      super
      @resource_type = :publisher
    end

    # Name
    #
    # @return [String]
    def name
      @metadata['name']
    end

    # Adds no value as value is Publisher
    # Type
    #
    # @return [String]
    # def type
    #   @metadata['type']
    # end

    # All metadata
    #
    # @return [Hash]
    def metadata
      @metadata
    end


    private

    # Adds no value as value is Publisher
    # def type
    #   path = '/typeClassification/term/localizedString'
    #   xpath_query_for_single_value path
    # end

    def combine_metadata
      o = super
      o['name'] = @extractor.name
      # o['type'] = type
      @metadata = o
    end

  end

end
