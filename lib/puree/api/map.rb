module Puree

  module API

    # Pure endpoints and corresponding XML root element in response.
    #
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
            }
          }
        }

        add_convention
        # add_family
      end

      # Gets endpoints with their corresponding XML response names.
      #
      # @return [Hash]
      def get
        @api_map
      end

      # Endpoint for resource type.
      #
      # @param resource_type [Symbol]
      # @return [String, nil]
      def service_name(resource_type)
        @api_map[:resource_type][resource_type][:service]
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

end