module Puree

  module XMLExtractor

    # Encoder.
    #
    module Encoder

      # Workaround for &lt; causing Nokogiri to throw character away
      # @return [String]
      def self.encode_doi(xml)
        to_replace = '&lt;'
        replacement = 'puree_lt'
        xml.gsub /(<doi>.*?)#{to_replace}(.*?<\/doi>)/, "\\1#{replacement}\\2"
      end

      # Workaround for &lt; causing Nokogiri to throw character away
      # @return [String]
      def self.decode_doi(str)
        str.gsub 'puree_lt', '<'
      end

    end

  end
end
