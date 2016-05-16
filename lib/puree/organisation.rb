module Puree

  # Organisation resource
  #
  class Organisation < Resource

    def initialize
      super(:organisation)
    end

    # Name
    #
    # @return [String]
    def name
      data = node 'name'
      !data.nil? && !data.empty? ? data['localizedString']['__content__'] : ''
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = {}
      o['name'] = name
      o
    end

  end

end
