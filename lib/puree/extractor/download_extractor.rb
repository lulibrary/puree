module Puree

  # Extractor
  #
  module Extractor

    # Download extractor
    #
    class Download < Puree::Extractor::Base

      def initialize(xml:)
        @resource_type = :download
        super
      end

      # Statistic
      #
      # @return [Array<Hash>]
      def statistic
        path = "#{service_response_name}/downloadCount"
        xpath_result = @doc.xpath(path)
        data_arr = []
        xpath_result.each { |i|
          data = {}
          data['uuid'] = i.attr('uuid').strip
          data['download'] = i.attr('downloads').strip
          data_arr << data
        }
        data_arr.uniq
      end

      # Is there any data after get?
      #
      # @return [Boolean]
      def get_data?
        # TO DO Inefficient!
        statistic.size ? true : false
      end

    end

  end

end