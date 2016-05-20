module Puree

  class Map

    def initialize
      @convention = %w(
        event
        journal
        organisation
        person
        project
        publication
        publisher
      )

      @api_map = {
        resource_type: {
          dataset: {
            service: 'datasets',
            response: 'GetDataSetsResponse'
          }
        }
      }

      add_convention
    end

    # Pure API map
    #
    # @return [Hash]
    def get
      @api_map
    end


    private

    def add_convention
      @convention.each do |c|
        resource_type = {}
        resource_type[:service] = c
        resource_type[:response] = 'Get' + c.capitalize + 'Response'
        @api_map[:resource_type][c.to_sym] = resource_type
      end
    end


  end

end