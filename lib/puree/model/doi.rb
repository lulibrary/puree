module Puree
  module Model

    # A DOI. Transforms HTML- and Hex-encoded DOI/DOI URL strings into a URL-friendly format.
    class DOI
      # @param str [String] DOI or DOI URL
      def initialize(str)
        raise ArgumentError if str.nil? || str.empty?
        @str = str
      end

      # Raw string
      # @return [String]
      def to_s
        @str
      end

      # URL-friendly DOI as a URL
      # @return [String, nil]
      def to_url
        return nil if !valid?
        doi = encode
        url_from_doi doi
      end

      # URL-friendly DOI
      # @return [String, nil]
      def encode
        return nil if !valid?
        doi = doi_from_url @str
        url_encode doi
      end

      # Namespace check
      # @return [Boolean]
      def valid?
        doi_from_url(@str).match(/^10\..+?/) ? true : false
      end

      private

      def url_encode(str)
        lt_substitute = 'lt_substitute'
        # substitute troublemaker
        lt_substituted = str.gsub '<', lt_substitute
        # convert xml/html encoded characters e.g. &gt; to characters e.g. >
        fragment = Nokogiri::XML.fragment lt_substituted
        # convert hex encoded characters e.g. %3E to characters e.g. >
        no_hex = URI::decode fragment.text
        # reinstate troublemaker
        to_encode = no_hex.gsub lt_substitute, '<'
        # finally, can encode
        URI::encode to_encode
      end

      def url_from_doi(str)
        "https://doi.org/#{str}"
      end

      def doi_from_url(str)
        s = str.dup
        # remove CrossRef format
        s.sub! /^.*?doi\.org\//, ''
        # remove DOI handbook format
        s.sub! /^doi:/i, ''
        s
      end
    end

  end
end