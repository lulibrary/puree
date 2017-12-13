module Puree

  module XMLExtractor

    # Download XML extractor.
    #
    class Download < Puree::XMLExtractor::Base

      def initialize(xml:)
        @resource_type = :download
        super
      end

      # Statistic
      #
      # @return [Array<Puree::Model::DownloadHeader>]
      def statistics
        path = "#{service_response_name}/downloadCount"
        xpath_result = @doc.xpath(path)
        data_arr = []
        xpath_result.each { |i|
          model = Puree::Model::DownloadHeader.new
          model.uuid = i.attr('uuid').strip
          model.count = i.attr('downloads').strip.to_i
          data_arr << model
        }
        data_arr.uniq { |d| d.uuid }
      end

      # Is there any data after get?
      #
      # @return [Boolean]
      def get_data?
        # TO DO Inefficient!
        statistics.size ? true : false
      end

    end

  end

end