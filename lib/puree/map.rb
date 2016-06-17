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
            response: 'GetDataSetsResponse',
            family: 'dk.atira.pure.modules.datasets.external.model.dataset.DataSet'
          },
          download: {
            service: 'downloadcount',
            response: 'GetDownloadCountResponse'
          },
          server: {
            service: 'servermeta',
            response: 'GetServerMetaResponse'
          },

        }
      }

      add_convention
      # add_family
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

    # def add_family
    #   @api_map[:resource_type][:event][:family] = 'dk.atira.pure.api.shared.model.event.Event'
    # end


  end

end